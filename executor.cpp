#include "executor.h"

Executor::Executor()
{
}
void Executor::getEnvironmentPath(){
    //调用系统api
    QString pathText = QProcessEnvironment::systemEnvironment().value("PATH");
//    QProcess p(0);
//    p.start("C:\\Windows\\System32\\cmd.exe");
//    p.write("set");
//    p.write("\r\n");
//    p.waitForStarted();
//    p.waitForBytesWritten();
//    p.waitForFinished();
//    QString out=QString::fromLocal8Bit(p.readAllStandardOutput());  //获得输出
//    int index=out.indexOf("set")+3;
//    out=out.mid(index,out.length()-index);
//    //分离
//    QStringList list=out.split("\r\n",QString::SkipEmptyParts);
//    list.removeLast();
//    QString pathText;
//    foreach (QString temp, list) {
//        if (temp.indexOf("Path=")==0){
//            pathText=temp.mid(5);
//        }
//    }
    QStringList pathList=pathText.split(";");
    pathList.removeLast();
    //构造json文本
    QJsonArray array;
    foreach (QString temp, pathList) {
        array.push_back(temp);
    }
    QByteArray byte_array =QJsonDocument(array).toJson();
    //"[\"path=hlxahslg\",\"path2=hlxahslg\",\"path3=hlxahslg\"]"
     emit sg_GetEnvironmentPath(byte_array);
}
void Executor::reWritePath(const QString &value)
{
    QStringList list=value.split(",");
    QString str;
    foreach (QString temp, list) {
        str.append(temp);
        str.append(";");
    }
    QString arg;
    arg.append("setx Path ");
    arg.append("\""+str+"\"");
    arg.append(" /m");
//    QProcess p(0);
//    p.start("C:\\Windows\\System32\\cmd.exe");
//    p.waitForStarted();
//    p.write(arg.toLatin1());
//    p.write("\r\n");
//    p.waitForBytesWritten();
//    p.waitForFinished();
    QProcess::execute(arg);

}
