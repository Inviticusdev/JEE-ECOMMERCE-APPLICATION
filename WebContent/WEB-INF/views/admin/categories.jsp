<%@ page language="java" contentType="text/html;"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cake Categories</title>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/style-admin.css"/>
    <script src="js/form-validation.js"></script> <!-- Ensure you have this JS file for validation -->
</head>
<body>
    <%@ include file="/WEB-INF/fragments/navbar.jspf" %>
    
    <sql:setDataSource dataSource="jdbc/e_commerce"/>

    <c:if test="${param.id != null && param.id.matches('[0-9]+')}">
        <!-- Confirm before deletion -->
        <c:if test="${param.confirm == 'yes'}">
            <sql:update>DELETE FROM categories WHERE id = ?
                <sql:param>${param.id }</sql:param>
            </sql:update>
        </c:if>
    </c:if>
    
    <c:if test='${pageContext.request.method == "POST" && param.label != null && !param.label.trim().isEmpty()}'>
        <sql:update>INSERT INTO categories(label) VALUES(?)
            <sql:param>${param.label }</sql:param>
        </sql:update>
    </c:if>

    <section id="categories" class="py-5 bg-faded">
        <div class="container table-container">
            <div class="row">
                <h4 class="display-4 mb-4">Cake Categories</h4>
                <div class="col-12 table-responsive-lg">
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Label</th>
                            <th scope="col">Cakes</th>
                            <th scope="col"></th>
                        </tr>
                        </thead>
                        <tbody>
                        <sql:query var="categories">SELECT c.id, label, COUNT(a.id) cakes FROM categories c LEFT JOIN products a ON c.id = a.category_id GROUP BY c.id, label</sql:query>
                        <c:forEach var="categorie" items="${categories.rows }">
                            <tr>
                                <th scope="row">${categorie.id }</th>
                                <td>${categorie.label }</td>
                                <td>${categorie.cakes }</td>
                                <td><a class="card-link" href="Categories?id=${categorie.id}&confirm=yes">Delete</a></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="row">
                <form class="form-inline col-12 mt-2 mb-5" action="Categories" method="POST" onsubmit="return validateCategoryForm()">
                    <label class="control-label col-md-3 mx-3" for="label">New Category</label>
                    <input id="label" name="label" type="text" maxlength="50" class="form-control col-md-6 mx-3 mr-auto" placeholder="Enter a label" required>
                    <button type="submit" class="btn btn-light form-control col-md-2 mx-3">Add</button>
                </form>
            </div>
        </div>
    </section>

    <c:set var="url">Categories</c:set>
    <%@ include file="/WEB-INF/fragments/footer.jspf" %>
</body>
</html>
