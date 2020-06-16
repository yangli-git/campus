<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2020/4/7
  Time: 17:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>书籍展示</title>
<%--    BootStrap美化界面--%>
    <link href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
<h1 style="margin: auto 600px">书籍展示</h1>
<div class="container">
    <div class="row clear">
        <div class="col-md-12 column">
            <div class="page-header">
                <h1>
                    <small>书籍列表-----------显示所有书籍</small>
                </h1>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 column form-inline">
                <a class="btn btn-primary" href="/book/toAddBook">增加书籍</a>
                <a class="btn btn-primary" href="/book/allBook">显示所有书籍</a>
                <%--            模糊查询--%>
                <form action="/book/selectBookByName" method="get" style="float: right">
                    <span style="color: red;font-weight: bold">${error}</span>
                    <input type="text" name="bookName" class="form-control" placeholder="请输入查询书籍名称">
                    <input type="submit" value="查询" class="btn-primary">
                </form>
            </div>
        </div>
<%--        <div class="col-md-4 column">--%>
<%--&lt;%&ndash;            模糊查询&ndash;%&gt;--%>
<%--            <form action="/book/selectBookByName" method="get" style="float: right">--%>
<%--                <input type="text" name="bookName" class="form-control" placeholder="请输入查询书籍名称">--%>
<%--                 <input type="submit" value="查询" class="btn-primary">--%>
<%--            </form>--%>
<%--        </div>--%>
    </div>
    <div class="row clear">
        <div class="col-md-12 column">
            <table class="table table-hover table-striped">
                <thead>
                <tr>
                    <th>书籍编号</th>
                    <th>书籍名称</th>
                    <th>书籍数量</th>
                    <th>书籍详情</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="book" items="${books}">
                    <tr>
                        <td>${book.bookId}</td>
                        <td>${book.bookName}</td>
                        <td>${book.bookCounts}</td>
                        <td>${book.detail}</td>
                        <td>
                            <a href="/book/toUpdateBook?id=${book.bookId}">修改</a>
                            &nbsp;|&nbsp;
                            <a href="/book/deleteBook?id=${book.bookId}">删除</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
