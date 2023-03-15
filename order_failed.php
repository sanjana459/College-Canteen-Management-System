<!DOCTYPE html>
<html lang="en">

<head>
    <?php 
        session_start(); 
        include("conn_db.php"); 
        include('head.php');
    ?>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="css/login.css" rel="stylesheet">

    <title>Failed to place an order | JSS Cafeteria</title>
</head>

<body class="d-flex flex-column h-100">
    <?php include('nav_header.php')?>
    <div class="mt-5"></div>
    <div class="container form-signin text-center reg-fail mt-auto">
            <?php
                if(isset($_GET["err"])){
                    $error_code = $_GET["err"];
                    $err_type = 1;
                    $display_msg =  "Error Code: {$error_code}";
                }else if(isset($_GET["pmt_err"])){
                    $err_type = 2;
                    $display_msg = "Message: ".ucfirst($_GET["pmt_err"]);
                }
            ?>
            <i class="mt-4 bi bi-exclamation-circle text-danger h1 display-2"></i>
            <h3 class="mt-2 mb-3 fw-normal text-bold">Unable to place your order</h3>
            <p class="mb-3 fw-normal text-bold">
                <?php 
                    switch($err_type){
                        case 1: echo "Sorry, the system has encountered with this error"; break;
                        case 2: echo "There is a problem with your payment"; break;
                        default: echo "There is an error in our system.";
                    }
                ?>
            <br/>
                <code><?php echo $display_msg;?></code>
            </p>
            <a class="btn btn-danger btn-sm w-50" href="index.php">Return to Home</a>
    </div>
    <footer
        class="footer d-flex flex-wrap justify-content-between align-items-center px-5 py-3 mt-auto bg-secondary text-light">
        <span class="smaller-font">&copy; 2023 JSSATE-B FoodGroup <br /><span class="xsmall-font">G.Sanjana Reddy, Anushka Roy</span></span>
        <span class="xsmall-font"> +91-9953411751 <br /><span class="xsmall-font">+91-9465911750</span></span>
    </footer>

    
</body>

</html>