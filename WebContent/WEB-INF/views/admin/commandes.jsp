<%@ page language="java" contentType="text/html;"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Orders</title>
    <link rel="stylesheet" href="css/bootstrap.min.css"/>
    <link rel="stylesheet" href="css/style-admin.css"/>
</head>
<body>
    <%@ include file="/WEB-INF/fragments/navbar.jspf" %>
    
    <sql:setDataSource dataSource="jdbc/e_commerce"/>

    <c:if test="${param.id != null && param.id.matches('[0-9]+')}">
        <!-- Add a confirmation prompt for order deletion -->
        <c:choose>
            <c:when test="${param.confirm == 'yes'}">
                <sql:update>DELETE FROM commandes WHERE id = ?
                    <sql:param>${param.id }</sql:param>
                </sql:update>
            </c:when>
            <c:otherwise>
                <!-- Display a confirmation message or link -->
                <!-- Implement a confirmation mechanism here -->
            </c:otherwise>
        </c:choose>
    </c:if>

    <section id="orders" class="py-5 bg-faded">
        <div class="container table-container">
            <div class="row">
                <h4 class="display-4 mb-4">List of Orders</h4>
                <div class="col-12 table-responsive-lg">
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Client</th>
                            <th scope="col">Date</th>
                            <th scope="col">Quantity</th>
                            <th scope="col">Total Price</th>
                            <th scope="col"></th>
                        </tr>
                        </thead>
                        <tbody>
                        <sql:query var="orders">
                            SELECT cm.id, CONCAT(cl.first_name, ' ', cl.last_name) as client, cm.order_date, 
                                   SUM(lc.quantity) as quantity, SUM(lc.quantity * a.price) as total_price
                            FROM orders cm
                            JOIN clients cl ON cm.client_id = cl.id
                            JOIN order_items lc ON cm.id = lc.order_id
                            JOIN products a ON lc.product_id = a.id
                            GROUP BY cm.id, cm.order_date, cl.first_name, cl.last_name
                            ORDER BY cm.id DESC
                        </sql:query>
                        <c:forEach var="order" items="${orders.rows}">
                            <tr>
                                <th scope="row">${order.id}</th>
                                <td>${order.client}</td>
                                <td><fmt:formatDate value="${order.order_date}" type="both" dateStyle="short" timeStyle="short"/></td>
                                <td>${order.quantity}</td>
                                <td><fmt:formatNumber value="${order.total_price}" type="currency"/></td>
                                <td><a class="card-link" href="Commandes?id=${order.id}&confirm=yes">Delete</a></td>
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
