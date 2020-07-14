import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick .Controls 2.12
import Executor 1.0
Window {
    visible: true
    width: 1000
    height: 500
    title: qsTr("Hello World")

    Column{
        anchors.fill: parent

        Row{
            width: parent.width
            height: parent.height
            Loader{
                id:loader
                width: parent.width-funcBar.width
                height: parent.height
                source: "MyViewer.qml"
            }
            Rectangle{
                id:funcBar
                width: 100
                height: parent.height
                color: "blue"
                Column{
                    spacing: 20  //相邻项的间隔
                    anchors.fill: parent
                    Button{
                        id:loadButton
                        text: "加载Path"
                        height: 30
                        width: parent.width
                        onClicked: {
                            executor.getEnvironmentPath()
                        }
                    }
                    Button{
                        id:addButton
                        text: "添加"
                        height: 30
                        width: parent.width
                        onClicked: {
                            popup.visible=true
                        }
                    }
                    Button{
                        id:deleteButton
                        text: "删除"
                        height: 30
                        width: parent.width
                        onClicked: {
                            loader.item.rect.deleteItem()

                        }
                    }
                    Button{
                        id:rewriteButton
                        text: "保存退出"
                        height: 30
                        width: parent.width
                        onClicked: {
                            var path_array=loader.item.rect.pathList
                            rewriteEnPath(path_array)
                            close()
                        }
                    }
                }
            }
        }

    }



    Executor{
        id:executor

    }
    Connections{
        target: executor
        function onSg_GetEnvironmentPath(value){
              loader.item.rect.loadItem(value)
        }

    }
    Popup {
            id: popup
            width: parent.width; height: parent.height
            x: parent.x; y:parent.y
            opacity: 0.7
            visible: false;
            Rectangle{
                id:pathAdder
                height: 30
                width: parent.width*0.6
                color: "grey"
                anchors.centerIn: parent
                TextField{
                    id:text_input
                    anchors.fill: parent
                    font.pointSize: 15
                    placeholderText: "请输入需添加的环境变量"
                }
            }
            Row{
                spacing: 20
                width: parent.width*0.6
                anchors.top: pathAdder.bottom
                x:pathAdder.x+width/2-100
                Button{
                    width: 100
                    height: 40
                    text: "确认添加"
                    onClicked: {
                        popup.visible=false
                        loader.item.rect.addItem(text_input.text)
                        text_input.text=""
                    }
                }
                Button{
                    width: 100
                    height: 40
                    text: "取消"
                    onClicked: {
                        popup.visible=false
                        text_input.text=""
                    }
                }
            }

        }
    function rewriteEnPath(pathArray){
            executor.reWritePath(pathArray)
    }

}

