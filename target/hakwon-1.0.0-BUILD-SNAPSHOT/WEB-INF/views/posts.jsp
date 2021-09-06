<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet"  type="text/css" href="https://cdn.datatables.net/1.11.1/css/jquery.dataTables.min.css"/>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.1/js/jquery.dataTables.min.js"></script>
</head>


<button onclick="location.href = 'posts/save'"> 글쓰기 </button>

<table id="postTable" class="table table-bordered">
    <thead>
    <tr>
        <th>게시물번호</th>
        <th>제목</th>
        <th>글쓴이</th>
        <th>날짜</th>
    </tr>
    </thead>
    <tbody>
        <tr>
            <td>1</td>
            <td>테스트</td>
            <td>테스트계정</td>
            <td>월요일</td>
        </tr>
    </tbody>
</table>

<script type="text/javascript" >

    $(document).ready(function () {



            $("#postTable").DataTable({
                serverSide: false,
            ajax : {
                "url":"/posts/dataTable",
                'dataSrc' :''
            },
            columns:[
                {data: "id"},
                {data: "title",
                    "render": function (data, type, row, meta) {
                        let path = row["id"];
                        if (type === 'display') {
                            console.log(row["id"])
                            data = '<a href="/posts/'+path+'">' + data +'</a>';   // /posts/{id}
                        }
                        return data;
                    }
                },
                {data: "creator"},
                {data: "createdDate"}
            ]
        });

    });

</script>