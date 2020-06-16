<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2020/4/7
  Time: 22:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改书籍</title>
    <link href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
<div class="container">
    <div class="row clear">
        <div class="col-md-12 column">
            <div class="page-header">
                <h1>
                    <small>修改书籍</small>
                </h1>
            </div>
        </div>
    </div>
    <form action="/book/updateBook" method="get">
<%--        隐藏id--%>
        <input type="hidden" name="bookId" value="${book.bookId}">
        <div class="form-group">
            <label for="bkid">书籍编号</label>

            <input type="text" class="form-control" name="bookId" id="bkid" value="${book.bookId}"  >
        </div>
        <div class="form-group">
            <label for="bkname">书籍名称</label>

            <input type="text" class="form-control" name="bookName" id="bkname" value="${book.bookName}"  >
        </div>
        <div class="form-group">
            <label for="bkcounts">书籍数量</label>
            <input type="text" class="form-control" name="bookCounts" id="bkcounts" value="${book.bookCounts}">
        </div>
        <div class="form-group">
            <label for="bkdetail">书籍详情</label>
            <input type="text" class="form-control" name="detail" id="bkdetail" value="${book.detail}">
        </div>
        <button type="submit" class="btn btn-default">修改</button>
    </form>
</div>
</body>
</html>
