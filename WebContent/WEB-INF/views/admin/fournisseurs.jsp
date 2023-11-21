<%@ page language="java" contentType="text/html;"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Suppliers</title>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/style-admin.css"/>
</head>
<body>
    <%@ include file="/WEB-INF/fragments/navbar.jspf" %>
    
    <sql:setDataSource dataSource="jdbc/e_commerce"/>

    <c:if test="${param.id != null && param.id.matches('[0-9]+')}">
        <!-- Add a confirmation prompt for supplier deletion -->
        <c:choose>
            <c:when test="${param.confirm == 'yes'}">
                <sql:update>DELETE FROM fournisseurs WHERE id = ?
                    <sql:param>${param.id }</sql:param>
                </sql:update>
            </c:when>
            <c:otherwise>
                <!-- Display a confirmation message or link -->
                <!-- Implement a confirmation mechanism here -->
            </c:otherwise>
        </c:choose>
    </c:if>

    <section id="suppliers" class="py-5 bg-faded">
        <div class="container table-container">
            <div class="row">
                <h4 class="display-4 mb-4">List of Suppliers</h4>
                <div class="col-12 table-responsive-lg">
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Name</th>
                            <th scope="col">Contact Person</th>
                            <th scope="col">Email</th>
                            <th scope="col">Address</th>
                            <th scope="col">Postal Code</th>
                            <th scope="col">City</th>
                            <th scope="col"></th>
                        </tr>
                        </thead>
                        <tbody>
                        <sql:query var="suppliers">SELECT * FROM fournisseurs ORDER BY id DESC</sql:query>
                        <c:forEach var="supplier" items="${suppliers.rows }">
                            <tr>
                                <th scope="row">${supplier.id }</th>
                                <td>${supplier.nom }</td>
                                <td>${supplier.prenom }</td>
                                <td>${supplier.email }</td>
                                <td>${supplier.addresse }</td>
                                <td>${supplier.codePostal }</td>
                                <td>${supplier.ville }</td>
                                <td><a class="card-link" href="Fournisseurs?id=${supplier.id}&confirm=yes">Delete</a></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </section>

    <%@ include file="/WEB-INF/fragments/footer.jspf" %>
</body>
</html>
