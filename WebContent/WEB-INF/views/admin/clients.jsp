<%@ page language="java" contentType="text/html;"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Clients</title>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/style-admin.css"/>
</head>
<body>
    <%@ include file="/WEB-INF/fragments/navbar.jspf" %>
    
    <sql:setDataSource dataSource="jdbc/e_commerce"/>

    <c:if test="${param.id != null && param.id.matches('[0-9]+')}">
        <!-- Add a confirmation prompt for client deletion -->
        <c:choose>
            <c:when test="${param.confirm == 'yes'}">
                <sql:update>DELETE FROM clients WHERE id = ?
                    <sql:param>${param.id }</sql:param>
                </sql:update>
            </c:when>
            <c:otherwise>
            </c:otherwise>
        </c:choose>
    </c:if>

    <section id="clients" class="py-5 bg-faded">
        <div class="container table-container">
            <div class="row">
                <h4 class="display-4 mb-4">List of Clients</h4>
                <div class="col-12 table-responsive-lg">
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Nom</th>
                            <th scope="col">Prenom</th>
                            <th scope="col">Email</th>
                            <th scope="col">Adresse</th>
                            <th scope="col">Code Postal</th>
                            <th scope="col">Ville</th>
                            <th scope="col"></th>
                        </tr>
                        </thead>
                        <tbody>
                        <sql:query var="clients">SELECT * FROM clients ORDER BY id DESC</sql:query>
                        <c:forEach var="client" items="${clients.rows }">
                            <tr>
                                <th scope="row">${client.id }</th>
                                <td>${client.nom }</td>
                                <td>${client.prenom }</td>
                                <td>${client.email }</td>
                                <td>${client.adresse }</td>
                                <td>${client.codePostal }</td>
                                <td>${client.ville }</td>
                                <td><a class="card-link" href="Clients?id=${client.id}&confirm=yes">Delete</a></td>
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
