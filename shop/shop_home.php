<!DOCTYPE html>
<html lang="en">

<head>
    <?php 
        session_start(); 
        if($_SESSION["utype"]!="shopowner"){
            header("location: ../restricted.php");
            exit(1);
        }
        include("../conn_db.php"); 
        include('../head.php');
        $s_id = $_SESSION["sid"];
    ?>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="../css/main.css" rel="stylesheet">
    <title>Shop Owner Home | JSS Cafeteria</title>
</head>

<body class="d-flex flex-column h-100">
    <?php include('nav_header_shop.php'); ?>

    <div class="d-flex text-center text-white promo-banner-bg py-3">
        <div class="p-lg-2 mx-auto my-3">
            <h1 class="display-5 fw-normal"><?php echo $_SESSION["shopname"]?></h1>
            <p class="lead fw-normal">JSSATE</p>
            
        </div>
    </div>

    <div class="container p-5" id="shop-dashboard">
        <h2 class="border-bottom pb-2"><i class="bi bi-graph-up"></i> Shop Dashboard <span
                class="small fw-light"><?php echo date('F j, Y');?></span></h2>

        <!-- SHOP OWNER GRID DASHBOARD -->
        <div class="row row-cols-1 row-cols-lg-2 align-items-stretch g-4 py-3">
            <!-- TODAY ORDER GRID -->
            <div class="col">
                <div class="card rounded-5 border-secondary p-2">
                    <div class="card-body">
                        <p class="card-title">
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                                class="bi bi-card-list" viewBox="0 0 16 16">
                                <path
                                    d="M14.5 3a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-.5.5h-13a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h13zm-13-1A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-13z" />
                                <path
                                    d="M5 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 5 8zm0-2.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zm0 5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zm-1-5a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0zM4 8a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0zm0 2.5a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0z" />
                            </svg>&nbsp;&nbsp;Orders</p>
                        <p class="card-text my-2">
                            <span class="display-5">
                                <?php 
                                    $query = "SELECT COUNT(*) AS cnt_order FROM order_header WHERE s_id = {$s_id} AND DATE(orh_pickuptime) = CURDATE() AND orh_orderstatus = 'FNSH';";
                                    $result = $mysqli -> query($query) -> fetch_array();
                                    echo $result["cnt_order"];
                                    ?>
                                Orders
                            </span>
                        </p>
                    </div>
                </div>
            </div>
            <!-- END TODAY ORDER GRID -->
            
            <!-- GRID OF MENU -->
            <div class="col">
                <a href="shop_menu_list.php" class="text-decoration-none text-dark">
                    <div class="card rounded-5 border p-2">
                        <div class="card-body">
                            <h5 class="card-title fw-light">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
                                    class="bi bi-card-list" viewBox="0 0 16 16">
                                    <path
                                        d="M14.5 3a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-.5.5h-13a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h13zm-13-1A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-13z" />
                                    <path
                                        d="M5 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 5 8zm0-2.5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zm0 5a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7a.5.5 0 0 1-.5-.5zm-1-5a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0zM4 8a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0zm0 2.5a.5.5 0 1 1-1 0 .5.5 0 0 1 1 0z" />
                                </svg>
                                Food Menu</h5>
                            <p class="card-text my-2">
                                <span class="h6">
                                    <?php
                                    $query = "SELECT COUNT(*) AS cnt_menu FROM food f INNER JOIN shop s ON f.s_id = s.s_id 
                                    WHERE (s.s_status = 1 AND (CURTIME() BETWEEN s.s_openhour AND s.s_closehour) AND f.f_todayavail = 1) OR (s.s_preorderstatus = 1 AND f.f_preorderavail = 1) AND s.s_id = {$s_id};";
                                    $result = $mysqli -> query($query) -> fetch_array();
                                    echo $result["cnt_menu"];
                                ?>
                                </span>
                                Menus available to order
                            </p>
                            <div class="text-end">
                                <a href="shop_menu_list.php" class="btn btn-sm btn-outline-dark">Go to Menu List</a>
                            </div>
                        </div>
                    </div>
                </a>
            </div>
            <!-- END GRID OF MENU -->
        </div>
        <!-- END ADMIN GRID DASHBOARD -->
    </div>
    <footer
        class="footer d-flex flex-wrap justify-content-between align-items-center px-5 py-3 mt-auto bg-secondary text-light">
        <span class="smaller-font">&copy; 2023 JSSATE-B FoodGroup <br /><span class="xsmall-font">G.Sanjana Reddy, Anushka Roy</span></span>
        <span class="xsmall-font"> +91-9953411751 <br /><span class="xsmall-font">+91-9465911750</span></span>
    </footer>
</body>

</html>