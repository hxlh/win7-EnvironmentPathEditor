import QtQuick 2.0

Rectangle{
    id:listItem
    property alias listItem: listItem
    property bool isclicked: false
    property int index:-1
    //一定记得设置高度哦
    height: 20
    width: parent.width
    color: "green"
    Row{
        width: parent.width
        TextInput{
            id:tex
            font.pointSize: 15
            text: "00"
            width: parent.width
        }
    }
    function set(path){
        tex.text=path
    }
    MouseArea{
        hoverEnabled: true
        anchors.fill: parent

        onClicked: {
            rect.checkClicked(index)//调用父文件方法检测
        }

        onEntered: {
            if(!isclicked){
                listItem.color="blue"
            }
        }

        onExited: {
            if(!isclicked){
                listItem.color="green"
            }
        }

    }
}
