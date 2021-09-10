<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <link rel="stylesheet"  type="text/css" href="https://cdn.datatables.net/1.11.1/css/jquery.dataTables.min.css"/>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.1/js/jquery.dataTables.min.js"></script>
</head>


<button onclick="location.href = 'posts/save'"> 글쓰기 </button>

<table border="0" cellspacing="5" cellpadding="5" align="right">
    <tbody><tr>
        <td>Tag :</td>
        <td><input type="text" id="tag" name="tag" placeholder="태그로 검색!"></td>
    </tr>
    </tbody>
</table>
<table id="postTable" class="table table-bordered" style="width: 100%">
    <thead>
    <tr>
        <th>게시물번호</th>
        <th>제목</th>
        <th>태그</th>
        <th>글쓴이</th>
        <th>날짜</th>
        <th>조회</th>
    </tr>
    </thead>
</table>

<script type="text/javascript" >

    $(document).ready(function () {


            $("#postTable").DataTable({
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
                            data = '<a href="/posts/'+path+'">' + data +'</a>';   // /posts/{id}
                        }
                        return data;
                    }
                },
                {data: "tag[]"},
                {data: "creator"},
                {data: "createdDate"},
                {data: "views"}
            ]
        });

        var table = $('#postTable').DataTable();

        $('#tag').keyup( function() {
            table
                .columns(2)
                .search(this.value)
                .draw();
        });
    });

</script>