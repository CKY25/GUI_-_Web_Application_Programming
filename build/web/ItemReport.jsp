<%-- 
    Document   : ItemReport
    Created on : May 5, 2023, 12:24:47 PM
    Author     : User
--%>

<%@page import="model.Staff"%>
<%@page import="model.Loginuser"%>
<%@page import="model.Item"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="AdminStaffNavBar.jsp"%>
<%
    List<Loginuser> ctList = (List) session.getAttribute("custList");
    List<Staff> stList = (List) session.getAttribute("staffList");
    String manager = (String) session.getAttribute("manager");
    System.out.println(manager);
    //Example user
    if ((ctList != null) || (stList != null) && (!manager.equals("manager"))) {
        // Customer is not authorized to access the restricted page
        RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
        rd.include(request, response);
        out.println("<script>let myModal = new bootstrap.Modal(document.getElementById('noPermission'), {});myModal.show();</script>");
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
        <title>Item Report</title>

        <!-- Favicon -->
        <link rel="icon" type="image/png" href="./src/img/logo.png" />

        <!-- Fonts-->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@500&display=swap" rel="stylesheet">

        <!-- CSS stylesheet -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.2.3/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css" />
        <link rel="stylesheet" href="./src/css/style.css" />
        <link rel="stylesheet" href="./src/css/itemstyle.css"/>
    </head>


    <body>
        <div id="blur">    
            <!-- Heading -->
            <div class="bg-primary mb-4" style="background-color: #3e3e3e !important">
                <div class="container py-4">
                    <h3 class="text-white mt-2">Item Report</h3>
                </div>
            </div>
            <!-- Heading -->

            <!-- sidebar + content -->
            <section class="" style="min-height: 600px">
                <div class="itemTable" style="margin-bottom: 50px">
                    <canvas id="itemMostChart" style="width:100%; max-width: 900px"></canvas>
                </div>
                
                <div class="itemTable">
                    <canvas id="itemLeastChart" style="width:100%; max-width: 900px"></canvas>
                </div>
                
                <div class="itemTable">
                    <button type="button" onclick="showReport()" id="showReportbtn">Show/Hide Detailed Report</button>
                </div>

                <div class="itemTable">
                    <table id="itemReport" class="table table-striped" style="display: none; border-collapse: collapse">
                        <caption style="caption-side: top; font-size: 30px;">Most 5 Sold Products</caption>
                        <thead class="table-dark">
                            <tr>
                                <th>Rank</th>
                                <th>Item Name</th>
                                <th>Item Price</th>
                                <th>Item Stock</th> 
                                <th>Item Sold Quantity</th>
                                <th>Item Image</th>
                            </tr>
                        </thead>

                        <%                            
                            List<Item> itemMostList = (List) session.getAttribute("reportMostList");
                            List<Item> itemLeastList = (List) session.getAttribute("reportLeastList");
                        %>
                        <tbody class="table-group-divider">
                            <% for (Item item : itemMostList) {%>
                            <tr>
                                <td id="<%= item.getItemid()%>"><%= itemMostList.indexOf(item) + 1%></td>
                                <td id="<%= item.getItemname()%>"><%= item.getItemname()%></td>
                                <td id="<%= item.getItemprice()%>"><%= item.getItemprice()%>0</td>
                                <td id="<%= item.getItemstock()%>"><%= item.getItemstock()%></td>
                                <td id="<%= item.getItemsoldqty()%>"><%= item.getItemsoldqty()%></td>
                                <td><img src="<%=item.getItemimage()%>" height="200" width="300"></td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>

                    <table id="itemReport" class="table table-striped" style="display: none; border-collapse: collapse">
                        <caption style="caption-side: top; font-size: 30px;">Least 5 Sold Products</caption>
                        <thead class="table-dark">
                            <tr>
                                <th>Rank</th>
                                <th>Item Name</th>
                                <th>Item Price</th>
                                <th>Item Stock</th> 
                                <th>Item Sold Quantity</th>
                                <th>Item Image</th>
                            </tr>
                        </thead>

                        <tbody class="table-group-divider">
                            <% for (Item item : itemLeastList) {%>
                            <tr>
                                <td id="<%= item.getItemid()%>"><%= itemLeastList.indexOf(item) + 1 %></td>
                                <td id="<%= item.getItemname()%>"><%= item.getItemname()%></td>
                                <td id="<%= item.getItemprice()%>"><%= item.getItemprice()%>0</td>
                                <td id="<%= item.getItemstock()%>"><%= item.getItemstock()%></td>
                                <td id="<%= item.getItemsoldqty()%>"><%= item.getItemsoldqty()%></td>
                                <td><img src="<%=item.getItemimage()%>" height="200" width="300"></td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>


            </section>
            <!-- sidebar + content -->

        </div>
        <!-- MDB -->
        <!-- Include Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.2.3/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
        <script>
            <%
                List<Item> reportMostList = (List) session.getAttribute("reportMostList");
            %>

                        var xValues = ["<%=reportMostList.get(0).getItemname()%>", "<%=reportMostList.get(1).getItemname()%>", "<%=reportMostList.get(2).getItemname()%>", "<%=reportMostList.get(3).getItemname()%>", "<%=reportMostList.get(4).getItemname()%>"];
                        var yValues = ["<%=reportMostList.get(0).getItemsoldqty()%>", "<%=reportMostList.get(1).getItemsoldqty()%>", "<%=reportMostList.get(2).getItemsoldqty()%>", "<%=reportMostList.get(3).getItemsoldqty()%>", "<%=reportMostList.get(4).getItemsoldqty()%>"];

                        var barColors = [
                            "#ffd0d0",
                            "#ffebd4",
                            "#f5ffd4",
                            "#d4ffd4",
                            "#d4eeff"
                        ];

                        var borderColors = 'black';

                        new Chart("itemMostChart",
                                {
                                    type: "doughnut",
                                    data: {
                                        labels: xValues,
                                        datasets: [{
                                                backgroundColor: barColors,
                                                borderColor: borderColors,
                                                data: yValues
                                            }]
                                    },
                                    options: {
                                        title: {
                                            display: true,
                                            text: "Most 5 Sold Products",
                                            fontSize: 50
                                        },
                                        tooltips: {
                                            bodyFontSize: 20
                                        },
                                        legend: {
                                            labels: {
                                                fontSize: 20
                                            }
                                        }
                                    }

                                }
                        );

                        var clicktimes = 0;
                        function showReport() {
                            let report = document.getElementsByClassName("table");
                            clicktimes++;
                            var styles1 = {
                                "width": "40%",
                                "display": "block",
                                "margin-top": "50px",
                                "align-content": "center",
                                "padding-right" : "50px",
                            };

                            var styles2 = {
                                "width": "40%",
                                "display": "none",
                                "margin-top": "50px",
                                "align-content": "center"
                            };

                            if (clicktimes % 2 !== 0){
                                Object.assign(report[0].style, styles1);
                                Object.assign(report[1].style, styles1);
                            }
                            else {
                                Object.assign(report[0].style, styles2);
                                Object.assign(report[1].style, styles2);
                            }
                                
                        }
        </script>

        <script>
            <%
                List<Item> reportLeastList = (List) session.getAttribute("reportLeastList");
            %>

            var xValues = ["<%=reportLeastList.get(0).getItemname()%>", "<%=reportLeastList.get(1).getItemname()%>", "<%=reportLeastList.get(2).getItemname()%>", "<%=reportLeastList.get(3).getItemname()%>", "<%=reportLeastList.get(4).getItemname()%>"];
            var yValues = ["<%=reportLeastList.get(0).getItemsoldqty()%>", "<%=reportLeastList.get(1).getItemsoldqty()%>", "<%=reportLeastList.get(2).getItemsoldqty()%>", "<%=reportLeastList.get(3).getItemsoldqty()%>", "<%=reportLeastList.get(4).getItemsoldqty()%>"];

            var barColors = [
                "#ffd0d0",
                "#ffebd4",
                "#f5ffd4",
                "#d4ffd4",
                "#d4eeff"
            ];

            var borderColors = 'black';

            new Chart("itemLeastChart",
                    {
                        type: "doughnut",
                        data: {
                            labels: xValues,
                            datasets: [{
                                    backgroundColor: barColors,
                                    borderColor: borderColors,
                                    data: yValues
                                }]
                        },
                        options: {
                            title: {
                                display: true,
                                text: "Least 5 Sold Products",
                                fontSize: 50
                            },
                            tooltips: {
                                bodyFontSize: 20
                            },
                            legend: {
                                labels: {
                                    fontSize: 20
                                }
                            }
                        }

                    }
            );
        </script>
        <%@include file="footer.jsp" %>
    </body>
</html>
