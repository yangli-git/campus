<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2020/4/7
  Time: 21:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>增加书籍</title>
    <link href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>
<div class="container">
    <div class="row clear">
        <div class="col-md-12 column">
            <div class="page-header">
                <h1>
                    <small>新增书籍</small>
                </h1>
            </div>
        </div>
    </div>
    <form action="/book/addBook" method="get">
        <div class="form-group">
            <label for="bkname">书籍名称</label>
            <input type="text" class="form-control" name="bookName" id="bkname" placeholder="书籍名称" required>
        </div>
        <div class="form-group">
            <label for="bkcounts">书籍数量</label>
            <input type="text" class="form-control" name="bookCounts" id="bkcounts" placeholder="书籍数量" required>
        </div>
        <div class="form-group">
            <label for="bkdetail">书籍详情</label>
            <input type="text" class="form-control" name="detail" id="bkdetail" placeholder="书籍详情" required>
        </div>
        <button type="submit" class="btn btn-default">添加</button>
    </form>
</div>
</body>
</html>
