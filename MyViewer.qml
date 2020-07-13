import QtQuick 2.12
import QtQuick.Controls 2.12
Rectangle{
    id:rect
    color: "red"
    anchors.fill: parent
    property alias rect: rect
    property var itemList: []
    property var pathList: []
    property int currentIndex: -1
    ScrollView{
        anchors.fill: parent
        Column{
            id:colu
            anchors.fill: parent

        }
    }

    function addItem(newPath){

        var com = Qt.createComponent("ListItem.qml");
        var object = com.createObject(colu);
        object.set(newPath)
        object.index=pathList.length
        itemList.push(object)
        pathList.push(newPath)
    }
    function deleteItem(){
        itemList[currentIndex].destroy()
        itemList.splice(currentIndex,1)
        pathList.splice(currentIndex,1)
        currentIndex=-1
        //重新排序调整index值
        for(var i=0;i<itemList.length;i++){
            itemList[i].index=i
        }
    }

    function loadItem(jsonData){
        //清空控件
        for(var j=0;j<itemList.length;j++){
           itemList[j].destroy()
        }
        //清空数组
        itemList.splice(0,itemList.length)
        //解析json文本
        var jst=JSON.parse(jsonData)
        var com = Qt.createComponent("ListItem.qml");
        for(var i=0;i<jst.length;i++){
            var object = com.createObject(colu);
            var path=jst[i]
            object.set(path)
            object.index=i
            itemList.push(object)//添加进入数组方便管理和销毁
            pathList.push(path)
        }

    }
    function checkClicked(index){
        console.log(index)
        currentIndex=index
        for(var i=0;i<itemList.length;i++){
                if(i ===index){
                    itemList[i].isclicked=true
                    itemList[i].color="#DFFDFD"

                }else{
                    itemList[i].isclicked=false
                    itemList[i].color="green"
                }
        }
    }
}

