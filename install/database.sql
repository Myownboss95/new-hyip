-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 24, 2023 at 11:08 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hyiplab_3.6`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `email`, `username`, `email_verified_at`, `image`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Super Admin', 'admin@site.com', 'admin', NULL, '6238276ac25d11647847274.png', '$2y$10$el35r0DVW8rbSEx0xm5xDu5IsbxmiaA1CZe3tfeub4iA4HxD1QSxq', '8T76MS12TDoSy5h11Zpjd2SJdLdm8eaRljohntFuPgDOp5kOiuAQD49AFipX', NULL, '2022-03-28 08:17:02');

-- --------------------------------------------------------

--
-- Table structure for table `admin_notifications`
--

CREATE TABLE `admin_notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `click_url` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admin_password_resets`
--

CREATE TABLE `admin_password_resets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cron_jobs`
--

CREATE TABLE `cron_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alias` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `action` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cron_schedule_id` int(11) NOT NULL DEFAULT 0,
  `next_run` datetime DEFAULT NULL,
  `last_run` datetime DEFAULT NULL,
  `is_running` tinyint(1) NOT NULL DEFAULT 1,
  `is_default` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cron_jobs`
--

INSERT INTO `cron_jobs` (`id`, `name`, `alias`, `action`, `url`, `cron_schedule_id`, `next_run`, `last_run`, `is_running`, `is_default`, `created_at`, `updated_at`) VALUES
(1, 'Interest Cron', 'interest_cron', '[\"App\\\\Http\\\\Controllers\\\\CronController\", \"interest\"]', NULL, 1, '2023-06-24 12:30:08', '2023-06-24 12:25:08', 1, 1, '2023-06-21 23:29:14', '2023-06-24 06:25:08'),
(2, 'Rank Cron', 'rank_cron', '[\"App\\\\Http\\\\Controllers\\\\CronController\", \"rank\"]', NULL, 1, '2023-06-24 12:30:08', '2023-06-24 12:25:08', 1, 1, '2023-06-22 06:04:49', '2023-06-24 06:25:08'),
(3, 'Schedule Invest', 'schedule_invest', '[\"App\\\\Http\\\\Controllers\\\\CronController\", \"investSchedule\"]', NULL, 1, '2023-06-24 12:30:08', '2023-06-24 12:25:08', 1, 1, '2023-06-22 06:10:31', '2023-06-24 06:25:08');

-- --------------------------------------------------------

--
-- Table structure for table `cron_job_logs`
--

CREATE TABLE `cron_job_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cron_job_id` int(11) NOT NULL DEFAULT 0,
  `start_at` datetime DEFAULT NULL,
  `end_at` datetime DEFAULT NULL,
  `duration` int(11) NOT NULL DEFAULT 0,
  `error` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cron_schedules`
--

CREATE TABLE `cron_schedules` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interval` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cron_schedules`
--

INSERT INTO `cron_schedules` (`id`, `name`, `interval`, `status`, `created_at`, `updated_at`) VALUES
(1, '5 Minutes', 300, 1, '2023-06-21 08:14:52', '2023-06-21 08:14:52'),
(2, '10 Minutes', 600, 1, '2023-06-21 23:28:22', '2023-06-21 23:28:22');

-- --------------------------------------------------------

--
-- Table structure for table `deposits`
--

CREATE TABLE `deposits` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `plan_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `method_code` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `method_currency` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `charge` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `rate` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `final_amo` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `detail` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `btc_amo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `btc_wallet` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trx` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_try` int(10) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1=>success, 2=>pending, 3=>cancel',
  `from_api` tinyint(1) NOT NULL DEFAULT 0,
  `admin_feedback` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `device_tokens`
--

CREATE TABLE `device_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `is_app` tinyint(1) NOT NULL DEFAULT 0,
  `token` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `extensions`
--

CREATE TABLE `extensions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `act` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `script` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shortcode` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'object',
  `support` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'help section',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=>enable, 2=>disable',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `extensions`
--

INSERT INTO `extensions` (`id`, `act`, `name`, `description`, `image`, `script`, `shortcode`, `support`, `status`, `created_at`, `updated_at`) VALUES
(1, 'tawk-chat', 'Tawk.to', 'Key location is shown bellow', 'tawky_big.png', '<script>\r\n                        var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();\r\n                        (function(){\r\n                        var s1=document.createElement(\"script\"),s0=document.getElementsByTagName(\"script\")[0];\r\n                        s1.async=true;\r\n                        s1.src=\"https://embed.tawk.to/{{app_key}}\";\r\n                        s1.charset=\"UTF-8\";\r\n                        s1.setAttribute(\"crossorigin\",\"*\");\r\n                        s0.parentNode.insertBefore(s1,s0);\r\n                        })();\r\n                    </script>', '{\"app_key\":{\"title\":\"App Key\",\"value\":\"------\"}}', 'twak.png', 0, '2019-10-18 23:16:05', '2022-09-25 00:58:09'),
(2, 'google-recaptcha2', 'Google Recaptcha 2', 'Key location is shown bellow', 'recaptcha3.png', '\n<script src=\"https://www.google.com/recaptcha/api.js\"></script>\n<div class=\"g-recaptcha\" data-sitekey=\"{{site_key}}\" data-callback=\"verifyCaptcha\"></div>\n<div id=\"g-recaptcha-error\"></div>', '{\"site_key\":{\"title\":\"Site Key\",\"value\":\"6LdPC88fAAAAADQlUf_DV6Hrvgm-pZuLJFSLDOWV\"},\"secret_key\":{\"title\":\"Secret Key\",\"value\":\"6LdPC88fAAAAAG5SVaRYDnV2NpCrptLg2XLYKRKB\"}}', 'recaptcha.png', 0, '2019-10-18 23:16:05', '2022-10-06 03:02:22'),
(3, 'custom-captcha', 'Custom Captcha', 'Just put any random string', 'customcaptcha.png', NULL, '{\"random_key\":{\"title\":\"Random String\",\"value\":\"SecureString\"}}', 'na', 0, '2019-10-18 23:16:05', '2022-10-06 03:02:25'),
(4, 'google-analytics', 'Google Analytics', 'Key location is shown bellow', 'google_analytics.png', '<script async src=\"https://www.googletagmanager.com/gtag/js?id={{app_key}}\"></script>\r\n                <script>\r\n                  window.dataLayer = window.dataLayer || [];\r\n                  function gtag(){dataLayer.push(arguments);}\r\n                  gtag(\"js\", new Date());\r\n                \r\n                  gtag(\"config\", \"{{app_key}}\");\r\n                </script>', '{\"app_key\":{\"title\":\"App Key\",\"value\":\"------\"}}', 'ganalytics.png', 0, NULL, '2021-05-04 10:19:12'),
(5, 'fb-comment', 'Facebook Comment ', 'Key location is shown bellow', 'Facebook.png', '<div id=\"fb-root\"></div><script async defer crossorigin=\"anonymous\" src=\"https://connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v4.0&appId={{app_key}}&autoLogAppEvents=1\"></script>', '{\"app_key\":{\"title\":\"App Key\",\"value\":\"----\"}}', 'fb_com.PNG', 0, NULL, '2022-09-25 01:22:33');

-- --------------------------------------------------------

--
-- Table structure for table `forms`
--

CREATE TABLE `forms` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `act` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `form_data` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `frontends`
--

CREATE TABLE `frontends` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `data_keys` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_values` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `template_name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `frontends`
--

INSERT INTO `frontends` (`id`, `data_keys`, `data_values`, `template_name`, `created_at`, `updated_at`) VALUES
(1, 'seo.data', '{\"seo_image\":\"1\",\"keywords\":[\"hyip\",\"bitcoin\",\"investment\",\"hyip business\",\"hyip script\",\"best hyip\",\"buy hyip script\",\"advanced hyip script\",\"hyip software\",\"hight yield investment program\",\"Hyip manager\",\"hyip manager script\",\"cheap hyip script\",\"realable hyip\",\"secure hyip script\",\"php hyip script\",\"new hyip script\",\"hyip program\"],\"description\":\"HYIPLab - Complete HYIP Investment System . Most Advanced HYIP Investment System Script in codecanyon.\\\\\\\\n\\\\\\\\nhyip, bitcoin, investment,  hyip business, hyip script, best hyip, buy hyip script, advanced hyip script, hyip software, high yield investment program, hyip manager, hyip manager script, cheap hyip script, reliable hyip, secure hyip script, php hyip script, new hyip script, hyip program\",\"social_title\":\"HYIPLab - Complete HYIP Investment System\",\"social_description\":\"HYIPLab - Complete HYIP Investment System . Most Advanced HYIP Investment System Script in codecanyon.\",\"image\":\"633eef9a9b3161665068954.jpg\"}', 'global', '2020-07-04 23:42:52', '2022-10-06 09:37:05'),
(41, 'cookie.data', '{\"short_desc\":\"We may use cookies or any other tracking technologies when you visit our website, including any other media form, mobile website, or mobile application related or connected to help customize the Site and improve your experience.\",\"description\":\"<div class=\\\"mb-5\\\">\\r\\n    <h3 class=\\\"mb-3\\\">\\r\\n        What information do we collect?<\\/h3>\\r\\n    <p class=\\\"font-18\\\">We gather data from you\\r\\n        when you register on our site, submit a request, buy any services, react to an overview, or round out a\\r\\n        structure. At the point when requesting any assistance or enrolling on our site, as suitable, you might be\\r\\n        approached to enter your: name, email address, or telephone number. You may, nonetheless, visit our site\\r\\n        anonymously.<\\/p>\\r\\n<\\/div>\\r\\n<div class=\\\"mb-5\\\">\\r\\n    <h3 class=\\\"mb-3\\\">\\r\\n        How do we protect your information?<\\/h3>\\r\\n    <p class=\\\"font-18\\\">All provided\\r\\n        delicate\\/credit data is sent through Stripe.<br>After an exchange, your private data (credit cards, social\\r\\n        security numbers, financials, and so on) won\'t be put away on our workers.<\\/p>\\r\\n<\\/div>\\r\\n<div class=\\\"mb-5\\\">\\r\\n    <h3 class=\\\"mb-3\\\">\\r\\n        Do we disclose any information to outside parties?<\\/h3>\\r\\n    <p class=\\\"font-18\\\">We don\'t sell, exchange,\\r\\n        or in any case move to outside gatherings by and by recognizable data. This does exclude confided in outsiders\\r\\n        who help us in working our site, leading our business, or adjusting you, since those gatherings consent to keep\\r\\n        this data private. We may likewise deliver your data when we accept discharge is suitable to follow the law,\\r\\n        implement our site strategies, or ensure our own or others\' rights, property, or wellbeing.<\\/p>\\r\\n<\\/div>\\r\\n<div class=\\\"mb-5\\\">\\r\\n    <h3 class=\\\"mb-3\\\">\\r\\n        Children\'s Online Privacy Protection Act Compliance<\\/h3>\\r\\n    <p class=\\\"font-18\\\">We are consistent with\\r\\n        the prerequisites of COPPA (Children\'s Online Privacy Protection Act), we don\'t gather any data from anybody\\r\\n        under 13 years old. Our site, items, and administrations are completely coordinated to individuals who are in\\r\\n        any event 13 years of age or more established.<\\/p>\\r\\n<\\/div>\\r\\n<div class=\\\"mb-5\\\">\\r\\n    <h3 class=\\\"mb-3\\\">\\r\\n        Changes to our Privacy Policy<\\/h3>\\r\\n    <p class=\\\"font-18\\\">If we decide to change\\r\\n        our privacy policy, we will post those changes on this page.<\\/p>\\r\\n<\\/div>\\r\\n<div class=\\\"mb-5\\\">\\r\\n    <h3 class=\\\"mb-3\\\">\\r\\n        How long we retain your information?<\\/h3>\\r\\n    <p class=\\\"font-18\\\">At the point when you\\r\\n        register for our site, we cycle and keep your information we have about you however long you don\'t erase the\\r\\n        record or withdraw yourself (subject to laws and guidelines).<\\/p>\\r\\n<\\/div>\\r\\n<div class=\\\"mb-5\\\">\\r\\n    <h3 class=\\\"mb-3\\\">\\r\\n        What we don\\u2019t do with your data<\\/h3>\\r\\n    <p class=\\\"font-18\\\">We don\'t and will never\\r\\n        share, unveil, sell, or in any case give your information to different organizations for the promoting of their\\r\\n        items or administrations.<\\/p>\\r\\n<\\/div>\",\"status\":1}', 'global', '2020-07-04 23:42:52', '2022-09-24 01:10:22'),
(44, 'maintenance.data', '{\"description\":\"<div class=\\\"text-center\\\"><h3 class=\\\"mb-3\\\">What information do we collect?<\\/h3>\\r\\n<p class=\\\"font-18\\\">We gather data from you when you register on our site, submit a request, buy any services, react to an overview, or round out a structure. At the point when requesting any assistance or enrolling on our site, as suitable, you might be approached to enter your: name, email address, or telephone number. You may, nonetheless, visit our site anonymously.<\\/p><\\/div>\"}', 'global', '2020-07-04 23:42:52', '2022-09-20 06:32:48'),
(206, 'about.content', '{\"has_image\":\"1\",\"heading_w\":\"About\",\"heading_c\":\"Us\",\"button_name\":\"More Info\",\"button_link\":\"about\",\"content\":\"We are an international financial company engaged in investment activities, which are related to trading on financial markets and cryptocurrency exchanges performed by qualified professional traders.\\r\\n\\r\\nOur goal is to provide our investors with a reliable source of high income, while minimizing any possible risks and offering a high-quality service, allowing us to automate and simplify the relations between the investors and the trustees. We work towards increasing your profit margin by profitable investment. We look forward to you being part of our community.\",\"image\":\"631d85749f9311662879092.jpg\"}', 'bit_gold', '2022-09-10 12:26:58', '2022-10-06 09:09:33'),
(207, 'banner.content', '{\"has_image\":\"1\",\"heading_w\":\"Invest for Future in Stable Platform\",\"heading_c\":\"and Make Fast Money\",\"sub_heading\":\"Invest in an Industry Leader, Professional, and Reliable Company. We provide you with the most necessary features that will make your experience better. Not only we guarantee the fastest and the most exciting returns on your investments, but we also guarantee the security of your investment.\",\"button_name\":\"Sign Up\",\"button_link\":\"user\\/register\",\"image\":\"631c9810cbce71662818320.jpg\"}', 'bit_gold', '2022-09-10 12:28:40', '2022-09-22 04:48:35'),
(208, 'blog.content', '{\"heading\":\"Our Latest News\",\"sub_heading\":\"you will get each update about our system and the world market in this area. Keep checking our Latest News to be in touch.\"}', 'bit_gold', '2022-09-10 12:28:58', '2022-09-10 12:28:58'),
(210, 'blog.content', '{\"heading\":\"Our Latest News\",\"sub_heading\":\"you will get each update about our system and the world market in this area. Keep checking our Latest News to be in touch.\"}', 'neo_dark', '2022-09-10 12:30:04', '2022-09-10 12:32:20'),
(216, 'about.content', '{\"has_image\":\"1\",\"heading\":\"About Us\",\"content\":\"We are an international financial company engaged in investment activities, which are related to trading on financial markets and cryptocurrency exchanges performed by qualified professional traders.\\r\\n\\r\\nOur goal is to provide our investors with a reliable source of high income, while minimizing any possible risks and offering a high-quality service, allowing us to automate and simplify the relations between the investors and the trustees. We work towards increasing your profit margin by profitable investment. We look forward to you being part of our community.\",\"image\":\"631d8591816a01662879121.png\"}', 'neo_dark', '2022-09-10 12:41:00', '2022-09-11 05:22:01'),
(217, 'banner.content', '{\"has_image\":\"1\",\"heading\":\"Invest for Future in Stable Platform and Make Fast Money\",\"button_name\":\"Sign Up\",\"button_link\":\"user\\/register\",\"button_two_name\":\"Sign In\",\"button_two_link\":\"user\\/login\",\"sub_heading\":\"Invest in an Industry Leader, Professional, and Reliable Company. We provide you with the most necessary features that will make your experience better. Not only we guarantee the fastest and the most exciting returns on your investments, but we also guarantee the security of your investment.\",\"image\":\"631d8664f2ab11662879332.png\"}', 'neo_dark', '2022-09-10 12:52:54', '2022-09-14 09:13:01'),
(218, 'calculation.content', '{\"heading_w\":\"Profit\",\"heading_c\":\"Calculator\",\"sub_heading\":\"You must know the calculation before investing in any plan, so you never make mistakes. Check the calculation and you will get as our calculator says.\"}', 'bit_gold', '2022-09-10 12:54:00', '2022-09-10 12:54:00'),
(219, 'calculation.content', '{\"has_image\":\"1\",\"heading\":\"Profit Calculator\",\"sub_heading\":\"You must know the calculation before investing in any plan, so you never make mistakes. Check the calculation and you will get as our calculator says.\",\"image\":\"633ef22566efe1665069605.png\"}', 'neo_dark', '2022-09-10 12:54:11', '2022-10-06 09:20:05'),
(220, 'contact.content', '{\"has_image\":\"1\",\"heading\":\"Contact With Us\",\"sub_heading\":\"If you have any questions or queries that are not answered on our website, please feel free to contact us. We will try to respond to you as soon as possible. Thank you so much.\",\"image\":\"631c9e4f1666c1662819919.jpg\"}', 'bit_gold', '2022-09-10 12:55:19', '2022-09-10 12:55:19'),
(221, 'contact.element', '{\"icon\":\"<i class=\\\"las la-phone\\\"><\\/i>\",\"title\":\"Phone Number\",\"content\":\"+01234 5678 9000\"}', 'bit_gold', '2022-09-10 12:55:45', '2022-09-10 12:55:46'),
(222, 'contact.element', '{\"icon\":\"<i class=\\\"far fa-envelope-open\\\"><\\/i>\",\"title\":\"Email Address\",\"content\":\"demo@example.com\"}', 'bit_gold', '2022-09-10 12:56:00', '2022-09-10 12:56:01'),
(223, 'contact.element', '{\"icon\":\"<i class=\\\"las la-map-marker\\\"><\\/i>\",\"title\":\"Office Address\",\"content\":\"3015 Suit pagla road, Singapore\"}', 'bit_gold', '2022-09-10 12:56:30', '2022-09-10 12:56:30'),
(224, 'contact.content', '{\"title\":null,\"subtitle\":null}', 'invester', '2022-09-10 12:57:59', '2022-09-10 12:57:59'),
(225, 'contact.element', '{\"icon\":\"<i class=\\\"las la-phone\\\"><\\/i>\",\"title\":\"Phone Number\",\"content\":\"+01234 5678 9000\"}', 'invester', '2022-09-10 12:57:59', '2022-09-10 12:57:59'),
(226, 'contact.element', '{\"icon\":\"<i class=\\\"far fa-envelope-open\\\"><\\/i>\",\"title\":\"Email Address\",\"content\":\"demo@example.com\"}', 'invester', '2022-09-10 12:57:59', '2022-09-10 12:57:59'),
(227, 'contact.element', '{\"icon\":\"<i class=\\\"las la-map-marker\\\"><\\/i>\",\"title\":\"Office Address\",\"content\":\"3015 Suit pagla road, Singapore\"}', 'invester', '2022-09-10 12:57:59', '2022-09-10 12:57:59'),
(228, 'cta.content', '{\"has_image\":\"1\",\"heading\":\"Get Started Today With Us\",\"sub_heading\":\"This is a Revolutionary Money Making Platform! Invest for Future in Stable Platform and Make Fast Money. Not only we guarantee the fastest and the most exciting returns on your investments, but we also guarantee the security of your investment.\",\"button_name\":\"Join Us\",\"button_url\":\"user\\/register\",\"image\":\"631c9f3d446e11662820157.jpg\"}', 'bit_gold', '2022-09-10 12:59:17', '2022-10-05 05:35:38'),
(229, 'faq.content', '{\"heading_w\":\"Frequently Asked\",\"heading_c\":\"Questions\",\"sub_heading\":\"We answer some of your Frequently Asked Questions regarding our platform. If you have a query that is not answered here, Please contact us.\"}', 'bit_gold', '2022-09-10 13:00:01', '2022-09-10 13:00:01'),
(230, 'faq.element', '{\"question\":\"When can I deposit\\/withdraw from my Investment account?\",\"answer\":\"Deposit and withdrawal are available for at any time. Be sure, that your funds are not used in any ongoing trade before the withdrawal. The available amount is shown in your dashboard on the main page of Investing platform.\\r\\n\\r\\n                                Deposit and withdrawal are available for at any time. Be sure, that your funds are not used in any ongoing trade before the withdrawal. The available amount is shown in your dashboard on the main page of Investing platform.\"}', 'bit_gold', '2022-09-10 13:00:23', '2022-09-10 13:00:23'),
(231, 'faq.element', '{\"question\":\"How do I check my account balance?\",\"answer\":\"You can see this anytime on your accounts dashboard. You can see this anytime on your accounts dashboard.\"}', 'bit_gold', '2022-09-10 13:00:39', '2022-09-10 13:00:39'),
(232, 'faq.element', '{\"question\":\"I forgot my password, what should I do?\",\"answer\":\"Visit the password reset page, type in your email address and click the `Reset` button. Visit the password reset page, type in your email address and click the `Reset` button.\"}', 'bit_gold', '2022-09-10 13:00:54', '2022-09-10 13:00:54'),
(233, 'faq.element', '{\"question\":\"How will I know that the withdrawal has been successful?\",\"answer\":\"You will get an automatic notification once we send the funds and you can always check your transactions or account balance. Your chosen payment system dictates how long it will take for the funds to reach you. You will get an automatic notification once we send the funds and you can always check your transactions or account balance. Your chosen payment system dictates how long it will take for the funds to reach you.\"}', 'bit_gold', '2022-09-10 13:01:07', '2022-09-10 13:01:07'),
(234, 'faq.element', '{\"question\":\"How much can I withdraw?\",\"answer\":\"You can withdraw the full amount of your account balance minus the funds that are used currently for supporting opened positions. You can withdraw the full amount of your account balance minus the funds that are used currently for supporting opened positions.\"}', 'bit_gold', '2022-09-10 13:01:21', '2022-09-10 13:01:22'),
(235, 'faq.content', '{\"heading\":\"Frequently Asked Questions\",\"sub_heading\":\"We answer some of your Frequently Asked Questions regarding our platform. If you have a query that is not answered here, Please contact us.\"}', 'neo_dark', '2022-09-10 13:01:37', '2022-09-11 05:33:28'),
(236, 'faq.element', '{\"question\":\"When can I deposit\\/withdraw from my Investment account?\",\"answer\":\"Deposit and withdrawal are available for at any time. Be sure, that your funds are not used in any ongoing trade before the withdrawal. The available amount is shown in your dashboard on the main page of Investing platform.\\r\\n\\r\\n                                Deposit and withdrawal are available for at any time. Be sure, that your funds are not used in any ongoing trade before the withdrawal. The available amount is shown in your dashboard on the main page of Investing platform.\"}', 'neo_dark', '2022-09-10 13:01:37', '2022-09-10 13:01:37'),
(237, 'faq.element', '{\"question\":\"How do I check my account balance?\",\"answer\":\"You can see this anytime on your accounts dashboard. You can see this anytime on your accounts dashboard.\"}', 'neo_dark', '2022-09-10 13:01:37', '2022-09-10 13:01:37'),
(238, 'faq.element', '{\"question\":\"I forgot my password, what should I do?\",\"answer\":\"Visit the password reset page, type in your email address and click the `Reset` button. Visit the password reset page, type in your email address and click the `Reset` button.\"}', 'neo_dark', '2022-09-10 13:01:37', '2022-09-10 13:01:37'),
(239, 'faq.element', '{\"question\":\"How will I know that the withdrawal has been successful?\",\"answer\":\"You will get an automatic notification once we send the funds and you can always check your transactions or account balance. Your chosen payment system dictates how long it will take for the funds to reach you. You will get an automatic notification once we send the funds and you can always check your transactions or account balance. Your chosen payment system dictates how long it will take for the funds to reach you.\"}', 'neo_dark', '2022-09-10 13:01:37', '2022-09-10 13:01:37'),
(240, 'faq.element', '{\"question\":\"How much can I withdraw?\",\"answer\":\"You can withdraw the full amount of your account balance minus the funds that are used currently for supporting opened positions.\"}', 'neo_dark', '2022-09-10 13:01:37', '2022-09-12 06:09:13'),
(241, 'faq.content', '{\"title\":null}', 'invester', '2022-09-10 13:01:55', '2022-09-10 13:01:55'),
(242, 'faq.element', '{\"question\":\"When can I deposit\\/withdraw from my Investment account?\",\"answer\":\"Deposit and withdrawal are available for at any time. Be sure, that your funds are not used in any ongoing trade before the withdrawal. The available amount is shown in your dashboard on the main page of Investing platform.\\r\\n\\r\\n                                Deposit and withdrawal are available for at any time. Be sure, that your funds are not used in any ongoing trade before the withdrawal. The available amount is shown in your dashboard on the main page of Investing platform.\"}', 'invester', '2022-09-10 13:01:55', '2022-09-10 13:01:55'),
(243, 'faq.element', '{\"question\":\"How do I check my account balance?\",\"answer\":\"You can see this anytime on your accounts dashboard. You can see this anytime on your accounts dashboard.\"}', 'invester', '2022-09-10 13:01:55', '2022-09-10 13:01:55'),
(244, 'faq.element', '{\"question\":\"I forgot my password, what should I do?\",\"answer\":\"Visit the password reset page, type in your email address and click the `Reset` button. Visit the password reset page, type in your email address and click the `Reset` button.\"}', 'invester', '2022-09-10 13:01:55', '2022-09-10 13:01:55'),
(245, 'faq.element', '{\"question\":\"How will I know that the withdrawal has been successful?\",\"answer\":\"You will get an automatic notification once we send the funds and you can always check your transactions or account balance. Your chosen payment system dictates how long it will take for the funds to reach you. You will get an automatic notification once we send the funds and you can always check your transactions or account balance. Your chosen payment system dictates how long it will take for the funds to reach you.\"}', 'invester', '2022-09-10 13:01:55', '2022-09-10 13:01:55'),
(246, 'faq.element', '{\"question\":\"How much can I withdraw?\",\"answer\":\"You can withdraw the full amount of your account balance minus the funds that are used currently for supporting opened positions. You can withdraw the full amount of your account balance minus the funds that are used currently for supporting opened positions.\"}', 'invester', '2022-09-10 13:01:55', '2022-09-10 13:01:55'),
(247, 'footer.content', '{\"has_image\":\"1\",\"image\":\"631ca001534431662820353.jpg\"}', 'bit_gold', '2022-09-10 13:02:33', '2022-09-10 13:02:33'),
(248, 'how_work.content', '{\"has_image\":\"1\",\"heading_w_1\":\"How\",\"heading_c\":\"Hyiplab\",\"heading_w_2\":\"Works\",\"sub_heading\":\"Get involved in our tremendous platform and Invest. We will utilize your money and give you profit in your wallet automatically.\",\"image\":\"631ca042137ab1662820418.jpg\"}', 'bit_gold', '2022-09-10 13:03:38', '2022-09-10 13:03:38'),
(249, 'how_work.element', '{\"title\":\"Create Account\",\"icon\":\"<i class=\\\"lar la-user\\\"><\\/i>\"}', 'bit_gold', '2022-09-10 13:03:57', '2022-09-10 13:03:57'),
(250, 'how_work.element', '{\"title\":\"Invest To Plan\",\"icon\":\"<i class=\\\"las la-clipboard-list\\\"><\\/i>\"}', 'bit_gold', '2022-09-10 13:04:20', '2022-09-10 13:04:20'),
(251, 'how_work.element', '{\"title\":\"Get Profit\",\"icon\":\"<i class=\\\"las la-wallet\\\"><\\/i>\"}', 'bit_gold', '2022-09-10 13:04:30', '2022-09-10 13:04:31'),
(252, 'how_work.content', '{\"heading\":\"How it Works\",\"sub_heading\":\"Get involved in our tremendous platform and Invest. We will utilize your money and give you profit in your wallet automatically.\"}', 'neo_dark', '2022-09-10 13:04:48', '2022-09-11 06:28:04'),
(253, 'how_work.element', '{\"icon\":\"<i class=\\\"lar la-user\\\"><\\/i>\",\"title\":\"Create Account\"}', 'neo_dark', '2022-09-10 13:04:48', '2022-09-10 13:04:48'),
(254, 'how_work.element', '{\"icon\":\"<i class=\\\"las la-clipboard-list\\\"><\\/i>\",\"title\":\"Invest To Plan\"}', 'neo_dark', '2022-09-10 13:04:48', '2022-09-10 13:04:48'),
(255, 'how_work.element', '{\"icon\":\"<i class=\\\"las la-wallet\\\"><\\/i>\",\"title\":\"Get Profit\"}', 'neo_dark', '2022-09-10 13:04:48', '2022-09-10 13:04:48'),
(256, 'login.content', '{\"has_image\":\"1\",\"heading_w\":\"Welcome To\",\"heading_c\":\"Hyiplab\",\"sub_heading\":\"Lorem ipsum dolor, sit amet consectetur adipisicing elit. Minus distinctio deserunt impedit similique debitis voluptatum enim.\",\"section_bg\":\"631ca0dc080a31662820572.jpg\",\"card_bg\":\"631ca0dc2ed1a1662820572.jpg\"}', 'bit_gold', '2022-09-10 13:06:11', '2022-09-10 13:06:12'),
(257, 'login.content', '{\"has_image\":\"1\",\"image\":\"631d951c9ede11662883100.png\"}', 'neo_dark', '2022-09-10 13:06:47', '2022-09-11 06:28:20'),
(258, 'plan.content', '{\"heading_w\":\"Investment\",\"heading_c\":\"Plans\",\"sub_heading\":\"To make a solid investment, you have to know where you are investing. Find a plan which is best for you.\"}', 'bit_gold', '2022-09-10 13:07:18', '2022-09-10 13:07:18'),
(259, 'plan.content', '{\"heading\":\"Investment Plans\",\"sub_heading\":\"To make a solid investment, you have to know where you are investing. Find a plan which is best for you.\"}', 'neo_dark', '2022-09-10 13:07:51', '2022-09-11 06:28:53'),
(260, 'policy_pages.element', '{\"title\":\"Privacy Policy\",\"details\":\"<h2 style=\\\"margin-bottom:10px;font-weight:600;line-height:24px;font-size:24px;font-family:DauphinPlain;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;\\\"><font color=\\\"#ffffff\\\">What is Lorem Ipsum?<\\/font><\\/h2><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><span style=\\\"font-weight:bolder;margin-top:0px;margin-right:0px;margin-left:0px;padding:0px;\\\">Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/font><\\/p><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><br \\/><\\/font><\\/p><h2 style=\\\"margin-bottom:10px;font-weight:600;line-height:24px;font-size:24px;font-family:DauphinPlain;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;\\\"><font color=\\\"#ffffff\\\">What is Lorem Ipsum?<\\/font><\\/h2><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><span style=\\\"font-weight:bolder;margin-top:0px;margin-right:0px;margin-left:0px;padding:0px;\\\">Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/font><\\/p><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><br \\/><\\/font><\\/p><h2 style=\\\"margin-bottom:10px;font-weight:600;line-height:24px;font-size:24px;font-family:DauphinPlain;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;\\\"><font color=\\\"#ffffff\\\">What is Lorem Ipsum?<\\/font><\\/h2><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><span style=\\\"font-weight:bolder;margin-top:0px;margin-right:0px;margin-left:0px;padding:0px;\\\">Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/font><\\/p><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><br \\/><\\/font><\\/p><h2 style=\\\"margin-bottom:10px;font-weight:600;line-height:24px;font-size:24px;font-family:DauphinPlain;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;\\\"><font color=\\\"#ffffff\\\">What is Lorem Ipsum?<\\/font><\\/h2><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><span style=\\\"font-weight:bolder;margin-top:0px;margin-right:0px;margin-left:0px;padding:0px;\\\">Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/font><\\/p><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><br \\/><\\/font><\\/p><h2 style=\\\"margin-bottom:10px;font-weight:600;line-height:24px;font-size:24px;font-family:DauphinPlain;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;\\\"><font color=\\\"#ffffff\\\">What is Lorem Ipsum?<\\/font><\\/h2><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><span style=\\\"font-weight:bolder;margin-top:0px;margin-right:0px;margin-left:0px;padding:0px;\\\">Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/font><\\/p><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><br \\/><\\/font><\\/p><h2 style=\\\"margin-bottom:10px;font-weight:600;line-height:24px;font-size:24px;font-family:DauphinPlain;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;\\\"><font color=\\\"#ffffff\\\">What is Lorem Ipsum?<\\/font><\\/h2><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><span style=\\\"font-weight:bolder;margin-top:0px;margin-right:0px;margin-left:0px;padding:0px;\\\">Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/font><\\/p><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><br \\/><\\/font><\\/p><h2 style=\\\"margin-bottom:10px;font-weight:600;line-height:24px;font-size:24px;font-family:DauphinPlain;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;\\\"><font color=\\\"#ffffff\\\">What is Lorem Ipsum?<\\/font><\\/h2><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><span style=\\\"font-weight:bolder;margin-top:0px;margin-right:0px;margin-left:0px;padding:0px;\\\">Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/font><\\/p><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><br \\/><\\/font><\\/p><h2 style=\\\"margin-bottom:10px;font-weight:600;line-height:24px;font-size:24px;font-family:DauphinPlain;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;\\\"><font color=\\\"#ffffff\\\">What is Lorem Ipsum?<\\/font><\\/h2><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><span style=\\\"font-weight:bolder;margin-top:0px;margin-right:0px;margin-left:0px;padding:0px;\\\">Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/font><\\/p>\"}', 'bit_gold', '2022-09-10 13:08:33', '2022-09-10 13:08:33'),
(261, 'policy_pages.element', '{\"title\":\"Terms and Service\",\"details\":\"<h2 style=\\\"margin-bottom:10px;font-weight:600;line-height:24px;font-size:24px;font-family:DauphinPlain;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;\\\"><font color=\\\"#ffffff\\\">What is Lorem Ipsum?<\\/font><\\/h2><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><span style=\\\"font-weight:bolder;margin-top:0px;margin-right:0px;margin-left:0px;padding:0px;\\\">Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/font><\\/p><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><br \\/><\\/font><\\/p><h2 style=\\\"margin-bottom:10px;font-weight:600;line-height:24px;font-size:24px;font-family:DauphinPlain;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;\\\"><font color=\\\"#ffffff\\\">What is Lorem Ipsum?<\\/font><\\/h2><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><span style=\\\"font-weight:bolder;margin-top:0px;margin-right:0px;margin-left:0px;padding:0px;\\\">Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/font><\\/p><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><br \\/><\\/font><\\/p><h2 style=\\\"margin-bottom:10px;font-weight:600;line-height:24px;font-size:24px;font-family:DauphinPlain;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;\\\"><font color=\\\"#ffffff\\\">What is Lorem Ipsum?<\\/font><\\/h2><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><span style=\\\"font-weight:bolder;margin-top:0px;margin-right:0px;margin-left:0px;padding:0px;\\\">Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/font><\\/p><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><br \\/><\\/font><\\/p><h2 style=\\\"margin-bottom:10px;font-weight:600;line-height:24px;font-size:24px;font-family:DauphinPlain;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;\\\"><font color=\\\"#ffffff\\\">What is Lorem Ipsum?<\\/font><\\/h2><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><span style=\\\"font-weight:bolder;margin-top:0px;margin-right:0px;margin-left:0px;padding:0px;\\\">Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/font><\\/p><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><br \\/><\\/font><\\/p><h2 style=\\\"margin-bottom:10px;font-weight:600;line-height:24px;font-size:24px;font-family:DauphinPlain;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;\\\"><font color=\\\"#ffffff\\\">What is Lorem Ipsum?<\\/font><\\/h2><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><span style=\\\"font-weight:bolder;margin-top:0px;margin-right:0px;margin-left:0px;padding:0px;\\\">Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/font><\\/p><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><br \\/><\\/font><\\/p><h2 style=\\\"margin-bottom:10px;font-weight:600;line-height:24px;font-size:24px;font-family:DauphinPlain;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;\\\"><font color=\\\"#ffffff\\\">What is Lorem Ipsum?<\\/font><\\/h2><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><span style=\\\"font-weight:bolder;margin-top:0px;margin-right:0px;margin-left:0px;padding:0px;\\\">Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/font><\\/p><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><br \\/><\\/font><\\/p><h2 style=\\\"margin-bottom:10px;font-weight:600;line-height:24px;font-size:24px;font-family:DauphinPlain;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;\\\"><font color=\\\"#ffffff\\\">What is Lorem Ipsum?<\\/font><\\/h2><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><span style=\\\"font-weight:bolder;margin-top:0px;margin-right:0px;margin-left:0px;padding:0px;\\\">Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/font><\\/p><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><br \\/><\\/font><\\/p><h2 style=\\\"margin-bottom:10px;font-weight:600;line-height:24px;font-size:24px;font-family:DauphinPlain;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;\\\"><font color=\\\"#ffffff\\\">What is Lorem Ipsum?<\\/font><\\/h2><p style=\\\"margin-right:0px;margin-bottom:15px;margin-left:0px;color:rgb(255,255,255);background-color:rgb(16,17,19);padding:0px;text-align:justify;font-family:\'Open Sans\', Arial, sans-serif;font-size:14px;\\\"><font color=\\\"#ffffff\\\"><span style=\\\"font-weight:bolder;margin-top:0px;margin-right:0px;margin-left:0px;padding:0px;\\\">Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.<\\/font><\\/p>\"}', 'bit_gold', '2022-09-10 13:08:46', '2022-09-10 13:08:46');
INSERT INTO `frontends` (`id`, `data_keys`, `data_values`, `template_name`, `created_at`, `updated_at`) VALUES
(262, 'policy_pages.element', '{\"title\":\"Privacy Policy\",\"details\":\"<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\\r\\n<p><br \\/>\\r\\n<\\/p>\\r\\n<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\\r\\n<p><br \\/>\\r\\n<\\/p>\\r\\n<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\\r\\n<p><br \\/>\\r\\n<\\/p>\\r\\n<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\\r\\n<p><br \\/>\\r\\n<\\/p>\\r\\n<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\\r\\n<p><br \\/>\\r\\n<\\/p>\\r\\n<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\\r\\n<p><br \\/>\\r\\n<\\/p>\\r\\n<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\\r\\n<p><br \\/>\\r\\n<\\/p>\\r\\n<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\"}', 'neo_dark', '2022-09-10 13:08:56', '2022-09-25 00:51:34'),
(263, 'policy_pages.element', '{\"title\":\"Terms and Service\",\"details\":\"<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\\r\\n<p><br \\/>\\r\\n<\\/p>\\r\\n<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\\r\\n<p><br \\/>\\r\\n<\\/p>\\r\\n<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\\r\\n<p><br \\/>\\r\\n<\\/p>\\r\\n<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\\r\\n<p><br \\/>\\r\\n<\\/p>\\r\\n<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\\r\\n<p><br \\/>\\r\\n<\\/p>\\r\\n<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\\r\\n<p><br \\/>\\r\\n<\\/p>\\r\\n<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\\r\\n<p><br \\/>\\r\\n<\\/p>\\r\\n<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\"}', 'neo_dark', '2022-09-10 13:08:56', '2022-10-06 02:59:37'),
(266, 'register.content', '{\"has_image\":\"1\",\"heading_w\":\"Welcome To\",\"heading_c\":\"Hyiplab\",\"sub_heading\":\"Lorem ipsum dolor, sit amet consectetur adipisicing elit. Minus distinctio deserunt impedit similique debitis voluptatum enim.\",\"section_bg\":\"631ca1b63bca31662820790.jpg\",\"card_bg\":\"631ca1b664ebf1662820790.jpg\"}', 'bit_gold', '2022-09-10 13:09:50', '2022-09-10 13:09:50'),
(267, 'social_icon.element', '{\"icon\":\"<i class=\\\"lab la-facebook-f\\\"><\\/i>\",\"url\":\"https:\\/\\/facebook.com\"}', 'bit_gold', '2022-09-10 13:10:11', '2022-10-05 05:37:49'),
(268, 'social_icon.element', '{\"icon\":\"<i class=\\\"lab la-twitter\\\"><\\/i>\",\"url\":\"https:\\/\\/twitter.com\"}', 'bit_gold', '2022-09-10 13:10:21', '2022-10-05 05:37:56'),
(269, 'social_icon.element', '{\"icon\":\"<i class=\\\"fab fa-pinterest-p\\\"><\\/i>\",\"url\":\"https:\\/\\/www.pinterest.com\"}', 'bit_gold', '2022-09-10 13:10:44', '2022-10-05 05:38:23'),
(270, 'social_icon.element', '{\"icon\":\"<i class=\\\"lab la-linkedin-in\\\"><\\/i>\",\"url\":\"https:\\/\\/www.linkedin.com\"}', 'bit_gold', '2022-09-10 13:11:07', '2022-10-05 05:38:40'),
(271, 'subscribe.content', '{\"has_image\":\"1\",\"heading\":\"Subscribe Our Newsletter\",\"image\":\"631ca2753add11662820981.jpg\"}', 'bit_gold', '2022-09-10 13:13:01', '2022-09-10 13:13:01'),
(272, 'subscribe.content', '{\"heading\":\"Subscribe Our Newsletter\",\"sub_heading\":\"once you subscribe to our newsletter, we will send our promo offers and news to your email. No worry, we will not send spam.\"}', 'neo_dark', '2022-09-10 13:13:14', '2022-09-11 06:29:18'),
(273, 'team.content', '{\"has_image\":\"1\",\"heading_w\":\"Our Expert\",\"heading_c\":\"Team Members\",\"sub_heading\":\"We have a great team including developers, designers, and Traders. The Team always working hard to give you the maximum profit.\",\"image\":\"631d7cee5a6e31662876910.jpg\"}', 'bit_gold', '2022-09-11 04:45:10', '2022-09-11 04:45:10'),
(274, 'team.element', '{\"has_image\":\"1\",\"name\":\"Callie Mcdowell\",\"designation\":\"CEO\",\"image\":\"631d7d27b87b91662876967.jpg\"}', 'bit_gold', '2022-09-11 04:46:07', '2022-09-11 04:46:07'),
(275, 'team.element', '{\"has_image\":\"1\",\"name\":\"Marcia Weeks\",\"designation\":\"CTO\",\"image\":\"631d7d3659a841662876982.jpg\"}', 'bit_gold', '2022-09-11 04:46:22', '2022-09-11 04:46:22'),
(276, 'team.element', '{\"has_image\":\"1\",\"name\":\"Sage Bray\",\"designation\":\"Marketing Head\",\"image\":\"631d7d451b43e1662876997.jpg\"}', 'bit_gold', '2022-09-11 04:46:37', '2022-09-11 04:46:37'),
(277, 'team.element', '{\"has_image\":\"1\",\"name\":\"Cyrus Briggs\",\"designation\":\"Developer\",\"image\":\"631d7d59199b41662877017.jpg\"}', 'bit_gold', '2022-09-11 04:46:56', '2022-09-11 04:46:57'),
(278, 'team.element', '{\"has_image\":\"1\",\"name\":\"Colette Mccarty\",\"designation\":\"UX Expert\",\"image\":\"631d7d67880c71662877031.jpg\"}', 'bit_gold', '2022-09-11 04:47:11', '2022-09-11 04:47:11'),
(279, 'team.element', '{\"has_image\":\"1\",\"name\":\"Alden Odom\",\"designation\":\"SEO Expert\",\"image\":\"631d7d89303111662877065.jpg\"}', 'bit_gold', '2022-09-11 04:47:45', '2022-09-11 04:47:45'),
(280, 'team.element', '{\"has_image\":\"1\",\"name\":\"Tanek Gilmore\",\"designation\":\"SEO Expert\",\"image\":\"631d7da2f198c1662877090.jpg\"}', 'bit_gold', '2022-09-11 04:48:10', '2022-09-11 04:48:11'),
(281, 'team.element', '{\"has_image\":\"1\",\"name\":\"Upton Blair\",\"designation\":\"Manager\",\"image\":\"631d7db766b581662877111.jpg\"}', 'bit_gold', '2022-09-11 04:48:31', '2022-09-11 04:48:31'),
(282, 'testimonial.content', '{\"has_image\":\"1\",\"heading_w\":\"What Users Say\",\"heading_c\":\"About Us\",\"sub_heading\":\"We are doing really good at this market and here are the words we loved to get from a few of our users.\",\"image\":\"631d7ddd2fe6c1662877149.jpg\"}', 'bit_gold', '2022-09-11 04:49:09', '2022-09-11 04:49:09'),
(283, 'testimonial.element', '{\"has_image\":\"1\",\"name\":\"Melodie Ferguson\",\"designation\":\"User from India\",\"quote\":\"I have invested with this platform and gotten my money in my account. This is legit and safe. Great doing business with them.\",\"image\":\"631d7e336da8c1662877235.jpg\"}', 'bit_gold', '2022-09-11 04:50:35', '2022-09-11 04:50:35'),
(284, 'testimonial.element', '{\"has_image\":\"1\",\"name\":\"Samantha Levy\",\"designation\":\"User From USA\",\"quote\":\"Legit....and legit. Although the payment was processed manually, I have received my first payment within a very short time., I think nice for invest at this site.\",\"image\":\"631d7e52d2dcf1662877266.jpg\"}', 'bit_gold', '2022-09-11 04:51:06', '2022-09-11 04:51:06'),
(285, 'testimonial.element', '{\"has_image\":\"1\",\"name\":\"Geoffrey Crawford\",\"designation\":\"User From Nigeria\",\"quote\":\"I have invested with this platform and gotten my money in my account. This is legit and safe. Great doing business with them.\",\"image\":\"631d7e6f11faf1662877295.jpg\"}', 'bit_gold', '2022-09-11 04:51:35', '2022-09-11 04:51:35'),
(286, 'top_investor.content', '{\"heading_w\":\"Our Top\",\"heading_c\":\"Investors\",\"sub_heading\":\"Here are the investor leaders who have made the maximum investment with our system.\"}', 'bit_gold', '2022-09-11 04:52:12', '2022-09-11 04:52:12'),
(287, 'transaction.content', '{\"heading_w\":\"Our Latest\",\"heading_c\":\"Transaction\",\"sub_heading\":\"Here is the log of the most recent transactions including withdraw and deposit made by our users.\"}', 'bit_gold', '2022-09-11 04:52:30', '2022-09-26 05:24:24'),
(288, 'we_accept.content', '{\"heading_w\":\"Payment We\",\"heading_c\":\"Accept\",\"sub_heading\":\"We accept all major cryptocurrencies and fiat payment methods to make your investment process easier with our platform.\"}', 'bit_gold', '2022-09-11 04:52:48', '2022-09-11 04:52:48'),
(289, 'why_choose.content', '{\"has_image\":\"1\",\"heading_w\":\"Why Choose\",\"heading_c\":\"Hyiplab\",\"sub_heading\":\"Our goal is to provide our investors with a reliable source of high income, while minimizing any possible risks and offering a high-quality service.\",\"image\":\"631d7ee5c26801662877413.jpg\"}', 'bit_gold', '2022-09-11 04:53:20', '2022-09-11 04:53:34'),
(290, 'why_choose.element', '{\"title\":\"Legal Company\",\"icon\":\"<i class=\\\"las la-copy\\\"><\\/i>\",\"content\":\"Our company conducts absolutely legal activities in the legal field. We are certified to operate investment business, we are legal and safe.\"}', 'bit_gold', '2022-09-11 04:53:56', '2022-09-11 04:53:56'),
(291, 'why_choose.element', '{\"title\":\"High reliability\",\"icon\":\"<i class=\\\"las la-lock\\\"><\\/i>\",\"content\":\"We are trusted by a huge number of people. We are working hard constantly to improve the level of our security system and minimize possible risks.\"}', 'bit_gold', '2022-09-11 04:54:12', '2022-09-11 04:54:12'),
(292, 'why_choose.element', '{\"title\":\"Anonymity\",\"icon\":\"<i class=\\\"las la-user-lock\\\"><\\/i>\",\"content\":\"Anonymity and using cryptocurrency as a payment instrument. In the era of electronic money \\u2013 this is one of the most convenient ways of cooperation.\"}', 'bit_gold', '2022-09-11 04:54:29', '2022-09-11 04:54:29'),
(293, 'why_choose.element', '{\"title\":\"Quick Withdrawal\",\"icon\":\"<i class=\\\"las la-shipping-fast\\\"><\\/i>\",\"content\":\"Our all retreats are treated spontaneously once requested. There are high maximum limits. The minimum withdrawal amount is only $10 .\"}', 'bit_gold', '2022-09-11 04:55:10', '2022-09-11 04:55:10'),
(294, 'why_choose.element', '{\"title\":\"Referral Program\",\"icon\":\"<i class=\\\"las la-link\\\"><\\/i>\",\"content\":\"We are offering a certain level of referral income through our referral program. you can increase your income by simply refer a few people.\"}', 'bit_gold', '2022-09-11 04:55:26', '2022-09-11 04:55:26'),
(295, 'why_choose.element', '{\"title\":\"24\\/7 Support\",\"icon\":\"<i class=\\\"las la-headset\\\"><\\/i>\",\"content\":\"We provide 24\\/7 customer support through e-mail and telegram. Our support representatives are periodically available to elucidate any difficulty.\"}', 'bit_gold', '2022-09-11 04:57:21', '2022-09-11 04:57:21'),
(296, 'why_choose.element', '{\"title\":\"Dedicated Server\",\"icon\":\"<i class=\\\"las la-server\\\"><\\/i>\",\"content\":\"We are using a dedicated server for the website which allows us exclusive use of the resources of the entire server.\"}', 'bit_gold', '2022-09-11 04:57:39', '2022-09-11 04:57:39'),
(297, 'why_choose.element', '{\"title\":\"SSL Secured\",\"icon\":\"<i class=\\\"lab la-expeditedssl\\\"><\\/i>\",\"content\":\"Comodo Essential-SSL Security encryption confirms that the presented content is genuine and legitimate.\"}', 'bit_gold', '2022-09-11 04:57:57', '2022-09-11 04:58:20'),
(298, 'why_choose.element', '{\"title\":\"DDOS Protection\",\"icon\":\"<i class=\\\"las la-shield-alt\\\"><\\/i>\",\"content\":\"We are using one of the most experienced, professional, and trusted DDoS Protection and mitigation provider.\"}', 'bit_gold', '2022-09-11 04:58:40', '2022-09-11 04:58:40'),
(299, 'breadcrumb.content', '{\"has_image\":\"1\",\"image\":\"631d82f525a611662878453.jpg\"}', 'bit_gold', '2022-09-11 05:10:53', '2022-09-11 05:10:53'),
(300, 'contact.content', '{\"heading\":\"Contact With Us\",\"sub_heading\":\"If you have any questions or queries that are not answered on our website, please feel free to contact us. We will try to respond to you as soon as possible. Thank you so much.\",\"map_api_key\":\"AIzaSyCo_pcAdFNbTDCAvMwAD19oRTuEmb9M50c\",\"latitude\":\"19.1368977\",\"longitude\":\"72.893736\",\"title\":\"Hello With Us\"}', 'neo_dark', '2022-09-11 05:28:18', '2022-09-15 06:15:05'),
(301, 'contact.element', '{\"icon\":\"<i class=\\\"las la-phone\\\"><\\/i>\",\"title\":\"Phone Number\",\"content\":\"+01234 5678 9000\"}', 'neo_dark', '2022-09-11 05:28:18', '2022-09-11 05:28:18'),
(302, 'contact.element', '{\"icon\":\"<i class=\\\"far fa-envelope-open\\\"><\\/i>\",\"title\":\"Email Address\",\"content\":\"demo@example.com\"}', 'neo_dark', '2022-09-11 05:28:18', '2022-09-11 05:28:18'),
(303, 'contact.element', '{\"icon\":\"<i class=\\\"las la-map-marker\\\"><\\/i>\",\"title\":\"Office Address\",\"content\":\"3015 Suit pagla road, Singapore\"}', 'neo_dark', '2022-09-11 05:28:18', '2022-09-11 05:28:18'),
(304, 'counter.element', '{\"title\":\"Investment\",\"counter_digit\":\"4k+\"}', 'neo_dark', '2022-09-11 05:32:24', '2022-09-11 05:32:24'),
(305, 'counter.element', '{\"title\":\"Withdraw\",\"counter_digit\":\"$160k+\"}', 'neo_dark', '2022-09-11 05:32:38', '2022-09-11 05:32:38'),
(306, 'counter.element', '{\"title\":\"Deposit\",\"counter_digit\":\"$250K+\"}', 'neo_dark', '2022-09-11 05:32:47', '2022-09-11 05:32:47'),
(307, 'counter.element', '{\"title\":\"Users\",\"counter_digit\":\"5K+\"}', 'neo_dark', '2022-09-11 05:32:55', '2022-09-11 05:32:55'),
(308, 'why_choose.content', '{\"heading\":\"Features - Why Choose Us\",\"sub_heading\":\"Our goal is to provide our investors with a reliable source of high income, while minimizing any possible risks and offering a high-quality service.\"}', 'neo_dark', '2022-09-11 05:35:34', '2022-09-11 05:35:41'),
(309, 'why_choose.element', '{\"title\":\"Legal Company\",\"icon\":\"<i class=\\\"las la-copy\\\"><\\/i>\",\"content\":\"Our company conducts absolutely legal activities in the legal field. We are certified to operate investment business, we are legal and safe.\"}', 'neo_dark', '2022-09-11 05:35:34', '2022-09-11 05:35:34'),
(310, 'why_choose.element', '{\"title\":\"High reliability\",\"icon\":\"<i class=\\\"las la-lock\\\"><\\/i>\",\"content\":\"We are trusted by a huge number of people. We are working hard constantly to improve the level of our security system and minimize possible risks.\"}', 'neo_dark', '2022-09-11 05:35:34', '2022-09-11 05:35:34'),
(311, 'why_choose.element', '{\"title\":\"Anonymity\",\"icon\":\"<i class=\\\"las la-user-lock\\\"><\\/i>\",\"content\":\"Anonymity and using cryptocurrency as a payment instrument. In the era of electronic money \\u2013 this is one of the most convenient ways of cooperation.\"}', 'neo_dark', '2022-09-11 05:35:34', '2022-09-11 05:35:34'),
(312, 'why_choose.element', '{\"title\":\"Quick Withdrawal\",\"icon\":\"<i class=\\\"las la-shipping-fast\\\"><\\/i>\",\"content\":\"Our all retreats are treated spontaneously once requested. There are high maximum limits. The minimum withdrawal amount is only $10 .\"}', 'neo_dark', '2022-09-11 05:35:34', '2022-09-11 05:35:34'),
(313, 'why_choose.element', '{\"title\":\"Referral Program\",\"icon\":\"<i class=\\\"las la-link\\\"><\\/i>\",\"content\":\"We are offering a certain level of referral income through our referral program. you can increase your income by simply refer a few people.\"}', 'neo_dark', '2022-09-11 05:35:34', '2022-09-11 05:35:34'),
(314, 'why_choose.element', '{\"title\":\"24\\/7 Support\",\"icon\":\"<i class=\\\"las la-headset\\\"><\\/i>\",\"content\":\"We provide 24\\/7 customer support through e-mail and telegram. Our support representatives are periodically available to elucidate any difficulty.\"}', 'neo_dark', '2022-09-11 05:35:34', '2022-09-11 05:35:34'),
(315, 'why_choose.element', '{\"title\":\"Dedicated Server\",\"icon\":\"<i class=\\\"las la-server\\\"><\\/i>\",\"content\":\"We are using a dedicated server for the website which allows us exclusive use of the resources of the entire server.\"}', 'neo_dark', '2022-09-11 05:35:34', '2022-09-11 05:35:34'),
(316, 'why_choose.element', '{\"title\":\"SSL Secured\",\"icon\":\"<i class=\\\"lab la-expeditedssl\\\"><\\/i>\",\"content\":\"Comodo Essential-SSL Security encryption confirms that the presented content is genuine and legitimate.\"}', 'neo_dark', '2022-09-11 05:35:34', '2022-09-11 05:35:34'),
(317, 'why_choose.element', '{\"title\":\"DDOS Protection\",\"icon\":\"<i class=\\\"las la-shield-alt\\\"><\\/i>\",\"content\":\"We are using one of the most experienced, professional, and trusted DDoS Protection and mitigation provider.\"}', 'neo_dark', '2022-09-11 05:35:34', '2022-09-11 05:35:34'),
(318, 'footer.content', '{\"content\":\"This is a Revolutionary Money Making Platform! Invest for Future in Stable Platform and Make Fast Money. Not only we guarantee the fastest and the most exciting returns on your investments, but we also guarantee the security of your investment.\"}', 'neo_dark', '2022-09-11 06:27:44', '2022-09-11 06:27:44'),
(319, 'register.content', '{\"has_image\":\"1\",\"image\":\"631d95465ec641662883142.png\"}', 'neo_dark', '2022-09-11 06:29:02', '2022-09-11 06:29:02'),
(320, 'team.content', '{\"heading\":\"Our Expert Team\",\"sub_heading\":\"We have a great team including developers, designers, and Traders. The Team always working hard to give you the maximum profit.\"}', 'neo_dark', '2022-09-11 06:29:34', '2022-09-11 06:30:08'),
(321, 'team.element', '{\"has_image\":\"1\",\"name\":\"Callie Mcdowell\",\"designation\":\"CEO\",\"image\":\"631d958f6449f1662883215.jpg\"}', 'neo_dark', '2022-09-11 06:29:34', '2022-09-11 06:30:15'),
(322, 'team.element', '{\"has_image\":\"1\",\"name\":\"Marcia Weeks\",\"designation\":\"CTO\",\"image\":\"631d9596177f91662883222.jpg\"}', 'neo_dark', '2022-09-11 06:29:34', '2022-09-11 06:30:22'),
(323, 'team.element', '{\"has_image\":\"1\",\"name\":\"Sage Bray\",\"designation\":\"Marketing Head\",\"image\":\"631d959daf20c1662883229.jpg\"}', 'neo_dark', '2022-09-11 06:29:35', '2022-09-11 06:30:29'),
(324, 'team.element', '{\"has_image\":\"1\",\"name\":\"Cyrus Briggs\",\"designation\":\"Developer\",\"image\":\"631d95a8c1e0e1662883240.jpg\"}', 'neo_dark', '2022-09-11 06:29:35', '2022-09-11 06:30:40'),
(325, 'team.element', '{\"has_image\":\"1\",\"name\":\"Colette Mccarty\",\"designation\":\"UX Expert\",\"image\":\"631d95b194e561662883249.jpg\"}', 'neo_dark', '2022-09-11 06:29:35', '2022-09-11 06:30:49'),
(326, 'team.element', '{\"has_image\":\"1\",\"name\":\"Alden Odom\",\"designation\":\"SEO Expert\",\"image\":\"631d95ba2bec21662883258.jpg\"}', 'neo_dark', '2022-09-11 06:29:35', '2022-09-11 06:30:58'),
(327, 'team.element', '{\"has_image\":\"1\",\"name\":\"Tanek Gilmore\",\"designation\":\"SEO Expert\",\"image\":\"631d95c577a5f1662883269.jpg\"}', 'neo_dark', '2022-09-11 06:29:35', '2022-09-11 06:31:09'),
(328, 'team.element', '{\"has_image\":\"1\",\"name\":\"Upton Blair\",\"designation\":\"Manager\",\"image\":\"631d95df9760a1662883295.jpg\"}', 'neo_dark', '2022-09-11 06:29:35', '2022-09-11 06:31:35'),
(329, 'testimonial.content', '{\"heading\":\"What Users Say\",\"sub_heading\":\"We are doing really good at this market and here are the words we loved to get from a few of our users.\"}', 'neo_dark', '2022-09-11 06:31:52', '2022-09-11 07:27:07'),
(330, 'testimonial.element', '{\"has_image\":\"1\",\"author\":\"John Doe\",\"designation\":\"User from India\",\"quote\":\"I have invested with this platform and gotten my money in my account. This is legit and safe. Great doing business with them.\",\"image\":\"6331b2d8be93f1664201432.jpg\"}', 'neo_dark', '2022-09-11 06:31:52', '2022-09-26 08:10:32'),
(331, 'testimonial.element', '{\"has_image\":\"1\",\"author\":\"Rodduka Bruch\",\"designation\":\"User From USA\",\"quote\":\"Legit....and legit. Although the payment was processed manually, I have received my first payment within a very short time., I think nice for invest at this site.\",\"image\":\"6331b2eae90971664201450.jpg\"}', 'neo_dark', '2022-09-11 06:31:52', '2022-09-26 08:10:50'),
(332, 'testimonial.element', '{\"has_image\":\"1\",\"author\":\"Putran Datta\",\"designation\":\"User From Nigeria\",\"quote\":\"I have invested with this platform and gotten my money in my account. This is legit and safe. Great doing business with them.\",\"image\":\"6331b301ac8011664201473.jpg\"}', 'neo_dark', '2022-09-11 06:31:52', '2022-09-26 08:11:13'),
(333, 'top_investor.content', '{\"heading\":\"Our Top Investors\",\"sub_heading\":\"Here are the investor leaders who have made the maximum investment with our system.\"}', 'neo_dark', '2022-09-11 07:27:12', '2022-09-11 07:27:33'),
(334, 'transaction.content', '{\"heading\":\"Our Latest Transaction\",\"sub_heading\":\"Here is the log of the most recent transactions including withdraw and deposit made by our users.\"}', 'neo_dark', '2022-09-11 07:27:56', '2022-09-11 07:28:38'),
(335, 'we_accept.content', '{\"heading\":\"Payment We Accept\",\"sub_heading\":\"We accept all major cryptocurrencies and fiat payment methods to make your investment process easier with our platform.\"}', 'neo_dark', '2022-09-11 07:28:45', '2022-09-26 08:17:06'),
(337, 'footer.content', '{\"content\":\"Lorem, ipsum dolor sit amet consectetur adipisicing elit. A ut aspernatur nesciunt dolores dolorem corrupti explicabo voluptate placeat impedit eveniet. Placeat soluta modi, dolor dolores iure eaque blanditiis labore temporibus cum magni rem accusantium eveniet? Quis suscipit\"}', 'invester', '2022-09-18 13:22:57', '2022-09-18 13:41:21'),
(338, 'authentication.content', '{\"register_title\":\"Create an Account\",\"register_subtitle\":\"You can create account using email or username and the registration is fully free\",\"login_title\":\"Login to your account\",\"login_subtitle\":\"You can sign in to your account using email or username\"}', 'invester', '2022-09-19 12:04:09', '2022-09-20 06:54:45'),
(340, 'preloader.content', '{\"has_image\":\"1\",\"image_one\":\"632ebf9b581241664008091.png\",\"image_two\":\"632ebf9b5e2681664008091.png\"}', 'bit_gold', '2022-09-24 01:30:47', '2022-09-24 02:28:11'),
(341, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"63319095f3d411664192661.jpg\"}', 'bit_gold', '2022-09-25 00:18:19', '2022-09-26 05:44:22'),
(343, 'transaction.element', '{\"trx_type\":\"withdraw\",\"name\":\"Benjamin Santos\",\"date\":\"2022-09-21\",\"amount\":\"120\",\"gateway\":\"Bank Wire\"}', 'bit_gold', '2022-09-26 05:24:52', '2022-09-26 05:26:42'),
(344, 'transaction.element', '{\"trx_type\":\"withdraw\",\"name\":\"Hilda Baird\",\"date\":\"2022-09-21\",\"amount\":\"365\",\"gateway\":\"Mobile Banking\"}', 'bit_gold', '2022-09-26 05:25:31', '2022-09-26 05:25:31'),
(345, 'transaction.element', '{\"trx_type\":\"withdraw\",\"name\":\"Glenna Mcdowell\",\"date\":\"2022-09-21\",\"amount\":\"325\",\"gateway\":\"Coin Transfer\"}', 'bit_gold', '2022-09-26 05:26:10', '2022-09-26 05:26:26'),
(346, 'transaction.element', '{\"trx_type\":\"withdraw\",\"name\":\"Ruth Herman\",\"date\":\"2022-09-21\",\"amount\":\"412\",\"gateway\":\"Bank Transfer\"}', 'bit_gold', '2022-09-26 05:27:05', '2022-09-26 05:27:05'),
(347, 'transaction.element', '{\"trx_type\":\"withdraw\",\"name\":\"Eve Hawkins\",\"date\":\"2022-09-21\",\"amount\":\"245\",\"gateway\":\"Mobile Banking\"}', 'bit_gold', '2022-09-26 05:27:47', '2022-09-26 05:27:47'),
(348, 'transaction.element', '{\"trx_type\":\"withdraw\",\"name\":\"Raphael Rush\",\"date\":\"2022-09-21\",\"amount\":\"365\",\"gateway\":\"Bank Wire\"}', 'bit_gold', '2022-09-26 05:28:23', '2022-09-26 05:28:23'),
(349, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"6331909d64be71664192669.jpg\"}', 'bit_gold', '2022-09-26 05:44:29', '2022-09-26 05:44:29'),
(350, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"633190a588df71664192677.jpg\"}', 'bit_gold', '2022-09-26 05:44:37', '2022-09-26 05:44:37'),
(351, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"633190ad89c261664192685.jpg\"}', 'bit_gold', '2022-09-26 05:44:45', '2022-09-26 05:44:45'),
(352, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"633190b56702e1664192693.jpg\"}', 'bit_gold', '2022-09-26 05:44:53', '2022-09-26 05:44:53'),
(353, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"633190beae8061664192702.jpg\"}', 'bit_gold', '2022-09-26 05:45:02', '2022-09-26 05:45:02'),
(354, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"633190c81d2361664192712.jpg\"}', 'bit_gold', '2022-09-26 05:45:12', '2022-09-26 05:45:12'),
(355, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"633190d1715f71664192721.jpg\"}', 'bit_gold', '2022-09-26 05:45:21', '2022-09-26 05:45:21'),
(356, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"633190dadd0f81664192730.jpg\"}', 'bit_gold', '2022-09-26 05:45:30', '2022-09-26 05:45:30'),
(357, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"633190e5aa7371664192741.jpg\"}', 'bit_gold', '2022-09-26 05:45:41', '2022-09-26 05:45:41'),
(358, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"633190f8ef6061664192760.jpg\"}', 'bit_gold', '2022-09-26 05:46:00', '2022-09-26 05:46:01'),
(359, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"63319103114611664192771.jpg\"}', 'bit_gold', '2022-09-26 05:46:11', '2022-09-26 05:46:11'),
(360, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"6331910d5ef4e1664192781.jpg\"}', 'bit_gold', '2022-09-26 05:46:21', '2022-09-26 05:46:21'),
(361, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"633191199cfcb1664192793.jpg\"}', 'bit_gold', '2022-09-26 05:46:33', '2022-09-26 05:46:33'),
(362, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"633191261ce231664192806.jpg\"}', 'bit_gold', '2022-09-26 05:46:46', '2022-09-26 05:46:46'),
(363, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"6331912f34a631664192815.jpg\"}', 'bit_gold', '2022-09-26 05:46:55', '2022-09-26 05:46:55'),
(364, 'blog.element', '{\"has_image\":[\"1\"],\"title\":\"Voluptatum est expedita officia established  fact\",\"description\":\"<span>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).\\u00a0It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/span><br \\/>\",\"image\":\"63319192e33ed1664192914.jpg\"}', 'bit_gold', '2022-09-26 05:48:34', '2022-09-26 05:48:35'),
(365, 'blog.element', '{\"has_image\":[\"1\"],\"title\":\"amet quisquam ut vitae debitis iste.\",\"description\":\"<span>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).\\u00a0It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/span><br \\/>\",\"image\":\"633191bed49ca1664192958.jpg\"}', 'bit_gold', '2022-09-26 05:49:18', '2022-09-26 05:49:19'),
(366, 'blog.element', '{\"has_image\":[\"1\"],\"title\":\"It is a long established fact that a reade\",\"description\":\"<span>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).\\u00a0It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/span><br \\/>\",\"image\":\"633191d9715801664192985.jpg\"}', 'bit_gold', '2022-09-26 05:49:45', '2022-09-26 05:49:45'),
(367, 'blog.element', '{\"has_image\":[\"1\"],\"title\":\"Voluptatum est expedita officia, eos\",\"description\":\"<span>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).\\u00a0It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/span><br \\/>\",\"image\":\"6331b1d007fc91664201168.jpg\"}', 'bit_gold', '2022-09-26 08:06:07', '2022-09-26 08:06:08'),
(368, 'blog.element', '{\"has_image\":[\"1\"],\"title\":\"Voluptatum est expedita officia, eos\",\"description\":\"<span>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).\\u00a0It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/span><br \\/>\",\"image\":\"6331b1e8db6511664201192.jpg\"}', 'bit_gold', '2022-09-26 08:06:32', '2022-09-26 08:06:33'),
(369, 'blog.element', '{\"has_image\":[\"1\"],\"title\":\"Voluptatum est expedita officia, eos\",\"description\":\"<span>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).\\u00a0It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/span><br \\/>\",\"image\":\"6331b1fab41151664201210.jpg\"}', 'bit_gold', '2022-09-26 08:06:50', '2022-09-26 08:06:50'),
(370, 'blog.element', '{\"has_image\":[\"1\"],\"title\":\"Voluptatum est expedita officia established  fact\",\"description\":\"<span>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).\\u00a0It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/span><br \\/>\",\"image\":\"6331b37472d271664201588.jpg\"}', 'neo_dark', '2022-09-26 08:12:59', '2022-09-26 08:13:08'),
(371, 'blog.element', '{\"has_image\":[\"1\"],\"title\":\"amet quisquam ut vitae debitis iste.\",\"description\":\"<span>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).\\u00a0It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/span><br \\/>\",\"image\":\"6331b37c360dc1664201596.jpg\"}', 'neo_dark', '2022-09-26 08:12:59', '2022-09-26 08:13:16'),
(372, 'blog.element', '{\"has_image\":[\"1\"],\"title\":\"It is a long established fact that a reade\",\"description\":\"<span>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).\\u00a0It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/span><br \\/>\",\"image\":\"6331b383af2971664201603.jpg\"}', 'neo_dark', '2022-09-26 08:12:59', '2022-09-26 08:13:23');
INSERT INTO `frontends` (`id`, `data_keys`, `data_values`, `template_name`, `created_at`, `updated_at`) VALUES
(373, 'blog.element', '{\"has_image\":[\"1\"],\"title\":\"Voluptatum est expedita officia, eos\",\"description\":\"<span>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).\\u00a0It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/span><br \\/>\",\"image\":\"6331b38b413b41664201611.jpg\"}', 'neo_dark', '2022-09-26 08:12:59', '2022-09-26 08:13:31'),
(374, 'blog.element', '{\"has_image\":[\"1\"],\"title\":\"Voluptatum est expedita officia, eos\",\"description\":\"<span>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).\\u00a0It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/span><br \\/>\",\"image\":\"6331b39334ed01664201619.jpg\"}', 'neo_dark', '2022-09-26 08:12:59', '2022-09-26 08:13:39'),
(375, 'blog.element', '{\"has_image\":[\"1\"],\"title\":\"Voluptatum est expedita officia, eos\",\"description\":\"<span>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).\\u00a0It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/span><br \\/>\",\"image\":\"6331b39b5cdf91664201627.jpg\"}', 'neo_dark', '2022-09-26 08:12:59', '2022-09-26 08:13:47'),
(376, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"6331b469adf241664201833.jpg\"}', 'neo_dark', '2022-09-26 08:16:59', '2022-09-26 08:17:13'),
(377, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"6331b478b064e1664201848.jpg\"}', 'neo_dark', '2022-09-26 08:16:59', '2022-09-26 08:17:28'),
(378, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"6331b48013ebe1664201856.jpg\"}', 'neo_dark', '2022-09-26 08:16:59', '2022-09-26 08:17:36'),
(379, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"6331b48911ad11664201865.jpg\"}', 'neo_dark', '2022-09-26 08:16:59', '2022-09-26 08:17:45'),
(380, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"6331b4911a65a1664201873.jpg\"}', 'neo_dark', '2022-09-26 08:16:59', '2022-09-26 08:17:53'),
(381, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"6331b49a692c51664201882.jpg\"}', 'neo_dark', '2022-09-26 08:16:59', '2022-09-26 08:18:02'),
(382, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"6331b4a689e2d1664201894.jpg\"}', 'neo_dark', '2022-09-26 08:17:00', '2022-09-26 08:18:14'),
(383, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"6331b4b7930091664201911.jpg\"}', 'neo_dark', '2022-09-26 08:17:00', '2022-09-26 08:18:31'),
(384, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"6331b4d1812581664201937.jpg\"}', 'neo_dark', '2022-09-26 08:17:00', '2022-09-26 08:18:57'),
(385, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"6331b4d8316831664201944.jpg\"}', 'neo_dark', '2022-09-26 08:17:00', '2022-09-26 08:19:04'),
(386, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"6331b4e1215b71664201953.jpg\"}', 'neo_dark', '2022-09-26 08:17:00', '2022-09-26 08:19:13'),
(387, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"6331b4e9889851664201961.jpg\"}', 'neo_dark', '2022-09-26 08:17:00', '2022-09-26 08:19:21'),
(388, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"6331b501a44a51664201985.jpg\"}', 'neo_dark', '2022-09-26 08:17:00', '2022-09-26 08:19:45'),
(389, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"6331b50c0cff01664201996.jpg\"}', 'neo_dark', '2022-09-26 08:17:00', '2022-09-26 08:19:56'),
(390, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"6331b51535bce1664202005.jpg\"}', 'neo_dark', '2022-09-26 08:17:00', '2022-09-26 08:20:05'),
(391, 'we_accept.element', '{\"has_image\":\"1\",\"image\":\"6331b5235e83d1664202019.jpg\"}', 'neo_dark', '2022-09-26 08:17:00', '2022-09-26 08:20:19'),
(394, 'policy_pages.element', '{\"title\":\"Privacy Policy\",\"details\":\"<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\\r\\n<p><br \\/>\\r\\n<\\/p>\\r\\n<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\\r\\n<p><br \\/>\\r\\n<\\/p>\\r\\n<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\\r\\n<p><br \\/>\\r\\n<\\/p>\\r\\n<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\\r\\n<p><br \\/>\\r\\n<\\/p>\\r\\n<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\\r\\n<p><br \\/>\\r\\n<\\/p>\\r\\n<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\\r\\n<p><br \\/>\\r\\n<\\/p>\\r\\n<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\\r\\n<p><br \\/>\\r\\n<\\/p>\\r\\n<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\"}', 'invester', '2022-09-26 08:22:15', '2022-09-26 08:22:15'),
(395, 'policy_pages.element', '{\"title\":\"Terms and Service\",\"details\":\"<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\\r\\n<p><br \\/>\\r\\n<\\/p>\\r\\n<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\\r\\n<p><br \\/>\\r\\n<\\/p>\\r\\n<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\\r\\n<p><br \\/>\\r\\n<\\/p>\\r\\n<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\\r\\n<p><br \\/>\\r\\n<\\/p>\\r\\n<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\\r\\n<p><br \\/>\\r\\n<\\/p>\\r\\n<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\\r\\n<p><br \\/>\\r\\n<\\/p>\\r\\n<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\\r\\n<p><br \\/>\\r\\n<\\/p>\\r\\n<h2>What is Lorem Ipsum?\\r\\n<\\/h2>\\r\\n<p><span>Lorem Ipsum<\\/span>\\u00a0is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the\\r\\n        industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled\\r\\n        it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic\\r\\n        typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset\\r\\n        sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker\\r\\n        including versions of Lorem Ipsum.\\r\\n<\\/p>\"}', 'invester', '2022-09-26 08:22:15', '2022-10-06 02:58:09'),
(396, 'how_it_work.content', '{\"title\":\"How HYIPLab Work\",\"subtitle\":\"To start with <span class=\\\"fw-bold\\\"><i>HYIPLab<\\/i><\\/span> you should know that how the system works. Please follow the below process to know that how the system works.\"}', 'invester', '2022-09-27 00:50:50', '2022-09-27 00:50:50'),
(397, 'how_it_work.element', '{\"has_image\":\"1\",\"title\":\"Create Account\",\"content\":\"Create an account providing your valid information\",\"image\":\"63329f02251e21664261890.png\"}', 'invester', '2022-09-27 00:58:10', '2022-09-27 00:58:10'),
(398, 'how_it_work.element', '{\"has_image\":\"1\",\"title\":\"Add Fund\",\"content\":\"Make deposit using our supported payment gateway\",\"image\":\"63329f26c36421664261926.png\"}', 'invester', '2022-09-27 00:58:46', '2022-09-27 00:58:46'),
(399, 'how_it_work.element', '{\"has_image\":\"1\",\"title\":\"Invest to Plan\",\"content\":\"Make investment to get profit from our system\",\"image\":\"63329f4740b7e1664261959.png\"}', 'invester', '2022-09-27 00:59:19', '2022-09-27 00:59:19'),
(400, 'how_it_work.element', '{\"has_image\":\"1\",\"title\":\"Withdraw Profit\",\"content\":\"Withdraw your profit which you\'ve got from the investment\",\"image\":\"63329f7b3bf561664262011.png\"}', 'invester', '2022-09-27 01:00:11', '2022-09-27 01:00:11'),
(401, 'testimonial.element', '{\"has_image\":\"1\",\"name\":\"David Doe\",\"designation\":\"User from England\",\"quote\":\"Legit....and legit. Although the payment was processed manually, I have received my first payment within a very short time., I think nice for invest at this site.\",\"image\":\"633edd66c19231665064294.jpg\"}', 'bit_gold', '2022-10-06 07:50:53', '2022-10-06 07:51:34'),
(411, 'preloader.content', '{\"has_image\":\"1\",\"image_one\":\"633efa583f0551665071704.png\",\"image_two\":\"633efa584317d1665071704.png\"}', 'neo_dark', '2022-10-06 09:55:04', '2022-10-06 09:55:04'),
(412, 'user_ranking.content', '{\"heading_w\":\"User Ranking\",\"heading_c\":\"Bonus\",\"sub_heading\":\"You can get bonus for investing or Interest.\"}', 'bit_gold', '2023-02-06 07:48:56', '2023-02-06 07:48:56'),
(413, 'user_ranking.content', '{\"heading\":\"User Ranking Bonus\",\"sub_heading\":\"You can get bonus for investing or Interest.\"}', 'neo_dark', '2023-02-06 23:51:09', '2023-02-06 23:51:35'),
(414, 'user_ranking.content', '{\"title\":\"User Ranking Bonus\",\"subtitle\":\"You can get bonus for investing or Interest.\"}', 'invester', '2023-02-07 00:15:49', '2023-02-07 00:15:49'),
(415, 'ranking.content', '{\"heading_w\":\"User\",\"heading_c\":\"Ranking\",\"sub_heading\":\"You can get a bonus to fulfill the requirement.\"}', 'bit_gold', '2023-03-11 01:25:36', '2023-03-11 02:56:24'),
(416, 'ranking.content', '{\"heading\":\"User Ranking\",\"sub_heading\":\"You can get a bonus to fulfill the requirement.\"}', 'invester', '2023-03-11 02:47:58', '2023-03-11 02:52:08'),
(417, 'ranking.content', '{\"heading\":\"User Ranking\",\"sub_heading\":\"You can get a bonus to fulfill the requirement.\"}', 'neo_dark', '2023-03-11 02:55:55', '2023-03-11 02:55:55');

-- --------------------------------------------------------

--
-- Table structure for table `gateways`
--

CREATE TABLE `gateways` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `form_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `code` int(10) DEFAULT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alias` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NULL',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=>enable, 2=>disable',
  `gateway_parameters` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supported_currencies` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `crypto` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: fiat currency, 1: crypto currency',
  `extra` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `gateways`
--

INSERT INTO `gateways` (`id`, `form_id`, `code`, `name`, `alias`, `status`, `gateway_parameters`, `supported_currencies`, `crypto`, `extra`, `description`, `created_at`, `updated_at`) VALUES
(1, 0, 101, 'Paypal', 'Paypal', 1, '{\"paypal_email\":{\"title\":\"PayPal Email\",\"global\":true,\"value\":\"sb-owud61543012@business.example.com\"}}', '{\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CZK\":\"CZK\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"HKD\":\"HKD\",\"HUF\":\"HUF\",\"INR\":\"INR\",\"ILS\":\"ILS\",\"JPY\":\"JPY\",\"MYR\":\"MYR\",\"MXN\":\"MXN\",\"TWD\":\"TWD\",\"NZD\":\"NZD\",\"NOK\":\"NOK\",\"PHP\":\"PHP\",\"PLN\":\"PLN\",\"GBP\":\"GBP\",\"RUB\":\"RUB\",\"SGD\":\"SGD\",\"SEK\":\"SEK\",\"CHF\":\"CHF\",\"THB\":\"THB\",\"USD\":\"$\"}', 0, NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 00:04:38'),
(2, 0, 102, 'Perfect Money', 'PerfectMoney', 1, '{\"passphrase\":{\"title\":\"ALTERNATE PASSPHRASE\",\"global\":true,\"value\":\"hR26aw02Q1eEeUPSIfuwNypXX\"},\"wallet_id\":{\"title\":\"PM Wallet\",\"global\":false,\"value\":\"\"}}', '{\"USD\":\"$\",\"EUR\":\"\\u20ac\"}', 0, NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 01:35:33'),
(3, 0, 103, 'Stripe Hosted', 'Stripe', 1, '{\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"sk_test_51I6GGiCGv1sRiQlEi5v1or9eR0HVbuzdMd2rW4n3DxC8UKfz66R4X6n4yYkzvI2LeAIuRU9H99ZpY7XCNFC9xMs500vBjZGkKG\"},\"publishable_key\":{\"title\":\"PUBLISHABLE KEY\",\"global\":true,\"value\":\"pk_test_51I6GGiCGv1sRiQlEOisPKrjBqQqqcFsw8mXNaZ2H2baN6R01NulFS7dKFji1NRRxuchoUTEDdB7ujKcyKYSVc0z500eth7otOM\"}}', '{\"USD\":\"USD\",\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"INR\":\"INR\",\"JPY\":\"JPY\",\"MXN\":\"MXN\",\"MYR\":\"MYR\",\"NOK\":\"NOK\",\"NZD\":\"NZD\",\"PLN\":\"PLN\",\"SEK\":\"SEK\",\"SGD\":\"SGD\"}', 0, NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 00:48:36'),
(4, 0, 104, 'Skrill', 'Skrill', 1, '{\"pay_to_email\":{\"title\":\"Skrill Email\",\"global\":true,\"value\":\"merchant@skrill.com\"},\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"---\"}}', '{\"AED\":\"AED\",\"AUD\":\"AUD\",\"BGN\":\"BGN\",\"BHD\":\"BHD\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"CZK\":\"CZK\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"HRK\":\"HRK\",\"HUF\":\"HUF\",\"ILS\":\"ILS\",\"INR\":\"INR\",\"ISK\":\"ISK\",\"JOD\":\"JOD\",\"JPY\":\"JPY\",\"KRW\":\"KRW\",\"KWD\":\"KWD\",\"MAD\":\"MAD\",\"MYR\":\"MYR\",\"NOK\":\"NOK\",\"NZD\":\"NZD\",\"OMR\":\"OMR\",\"PLN\":\"PLN\",\"QAR\":\"QAR\",\"RON\":\"RON\",\"RSD\":\"RSD\",\"SAR\":\"SAR\",\"SEK\":\"SEK\",\"SGD\":\"SGD\",\"THB\":\"THB\",\"TND\":\"TND\",\"TRY\":\"TRY\",\"TWD\":\"TWD\",\"USD\":\"USD\",\"ZAR\":\"ZAR\",\"COP\":\"COP\"}', 0, NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 01:30:16'),
(5, 0, 105, 'PayTM', 'Paytm', 1, '{\"MID\":{\"title\":\"Merchant ID\",\"global\":true,\"value\":\"DIY12386817555501617\"},\"merchant_key\":{\"title\":\"Merchant Key\",\"global\":true,\"value\":\"bKMfNxPPf_QdZppa\"},\"WEBSITE\":{\"title\":\"Paytm Website\",\"global\":true,\"value\":\"DIYtestingweb\"},\"INDUSTRY_TYPE_ID\":{\"title\":\"Industry Type\",\"global\":true,\"value\":\"Retail\"},\"CHANNEL_ID\":{\"title\":\"CHANNEL ID\",\"global\":true,\"value\":\"WEB\"},\"transaction_url\":{\"title\":\"Transaction URL\",\"global\":true,\"value\":\"https:\\/\\/pguat.paytm.com\\/oltp-web\\/processTransaction\"},\"transaction_status_url\":{\"title\":\"Transaction STATUS URL\",\"global\":true,\"value\":\"https:\\/\\/pguat.paytm.com\\/paytmchecksum\\/paytmCallback.jsp\"}}', '{\"AUD\":\"AUD\",\"ARS\":\"ARS\",\"BDT\":\"BDT\",\"BRL\":\"BRL\",\"BGN\":\"BGN\",\"CAD\":\"CAD\",\"CLP\":\"CLP\",\"CNY\":\"CNY\",\"COP\":\"COP\",\"HRK\":\"HRK\",\"CZK\":\"CZK\",\"DKK\":\"DKK\",\"EGP\":\"EGP\",\"EUR\":\"EUR\",\"GEL\":\"GEL\",\"GHS\":\"GHS\",\"HKD\":\"HKD\",\"HUF\":\"HUF\",\"INR\":\"INR\",\"IDR\":\"IDR\",\"ILS\":\"ILS\",\"JPY\":\"JPY\",\"KES\":\"KES\",\"MYR\":\"MYR\",\"MXN\":\"MXN\",\"MAD\":\"MAD\",\"NPR\":\"NPR\",\"NZD\":\"NZD\",\"NGN\":\"NGN\",\"NOK\":\"NOK\",\"PKR\":\"PKR\",\"PEN\":\"PEN\",\"PHP\":\"PHP\",\"PLN\":\"PLN\",\"RON\":\"RON\",\"RUB\":\"RUB\",\"SGD\":\"SGD\",\"ZAR\":\"ZAR\",\"KRW\":\"KRW\",\"LKR\":\"LKR\",\"SEK\":\"SEK\",\"CHF\":\"CHF\",\"THB\":\"THB\",\"TRY\":\"TRY\",\"UGX\":\"UGX\",\"UAH\":\"UAH\",\"AED\":\"AED\",\"GBP\":\"GBP\",\"USD\":\"USD\",\"VND\":\"VND\",\"XOF\":\"XOF\"}', 0, NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 03:00:44'),
(6, 0, 106, 'Payeer', 'Payeer', 0, '{\"merchant_id\":{\"title\":\"Merchant ID\",\"global\":true,\"value\":\"866989763\"},\"secret_key\":{\"title\":\"Secret key\",\"global\":true,\"value\":\"7575\"}}', '{\"USD\":\"USD\",\"EUR\":\"EUR\",\"RUB\":\"RUB\"}', 0, '{\"status\":{\"title\": \"Status URL\",\"value\":\"ipn.Payeer\"}}', NULL, '2019-09-14 13:14:22', '2020-12-28 01:26:58'),
(7, 0, 107, 'PayStack', 'Paystack', 1, '{\"public_key\":{\"title\":\"Public key\",\"global\":true,\"value\":\"pk_test_cd330608eb47970889bca397ced55c1dd5ad3783\"},\"secret_key\":{\"title\":\"Secret key\",\"global\":true,\"value\":\"sk_test_8a0b1f199362d7acc9c390bff72c4e81f74e2ac3\"}}', '{\"USD\":\"USD\",\"NGN\":\"NGN\"}', 0, '{\"callback\":{\"title\": \"Callback URL\",\"value\":\"ipn.Paystack\"},\"webhook\":{\"title\": \"Webhook URL\",\"value\":\"ipn.Paystack\"}}\r\n', NULL, '2019-09-14 13:14:22', '2021-05-21 01:49:51'),
(8, 0, 108, 'VoguePay', 'Voguepay', 1, '{\"merchant_id\":{\"title\":\"MERCHANT ID\",\"global\":true,\"value\":\"demo\"}}', '{\"USD\":\"USD\",\"GBP\":\"GBP\",\"EUR\":\"EUR\",\"GHS\":\"GHS\",\"NGN\":\"NGN\",\"ZAR\":\"ZAR\"}', 0, NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 01:22:38'),
(9, 0, 109, 'Flutterwave', 'Flutterwave', 1, '{\"public_key\":{\"title\":\"Public Key\",\"global\":true,\"value\":\"----------------\"},\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"-----------------------\"},\"encryption_key\":{\"title\":\"Encryption Key\",\"global\":true,\"value\":\"------------------\"}}', '{\"BIF\":\"BIF\",\"CAD\":\"CAD\",\"CDF\":\"CDF\",\"CVE\":\"CVE\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"GHS\":\"GHS\",\"GMD\":\"GMD\",\"GNF\":\"GNF\",\"KES\":\"KES\",\"LRD\":\"LRD\",\"MWK\":\"MWK\",\"MZN\":\"MZN\",\"NGN\":\"NGN\",\"RWF\":\"RWF\",\"SLL\":\"SLL\",\"STD\":\"STD\",\"TZS\":\"TZS\",\"UGX\":\"UGX\",\"USD\":\"USD\",\"XAF\":\"XAF\",\"XOF\":\"XOF\",\"ZMK\":\"ZMK\",\"ZMW\":\"ZMW\",\"ZWD\":\"ZWD\"}', 0, NULL, NULL, '2019-09-14 13:14:22', '2021-06-05 11:37:45'),
(10, 0, 110, 'RazorPay', 'Razorpay', 1, '{\"key_id\":{\"title\":\"Key Id\",\"global\":true,\"value\":\"rzp_test_kiOtejPbRZU90E\"},\"key_secret\":{\"title\":\"Key Secret \",\"global\":true,\"value\":\"osRDebzEqbsE1kbyQJ4y0re7\"}}', '{\"INR\":\"INR\"}', 0, NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 02:51:32'),
(11, 0, 111, 'Stripe Storefront', 'StripeJs', 1, '{\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"sk_test_51I6GGiCGv1sRiQlEi5v1or9eR0HVbuzdMd2rW4n3DxC8UKfz66R4X6n4yYkzvI2LeAIuRU9H99ZpY7XCNFC9xMs500vBjZGkKG\"},\"publishable_key\":{\"title\":\"PUBLISHABLE KEY\",\"global\":true,\"value\":\"pk_test_51I6GGiCGv1sRiQlEOisPKrjBqQqqcFsw8mXNaZ2H2baN6R01NulFS7dKFji1NRRxuchoUTEDdB7ujKcyKYSVc0z500eth7otOM\"}}', '{\"USD\":\"USD\",\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"INR\":\"INR\",\"JPY\":\"JPY\",\"MXN\":\"MXN\",\"MYR\":\"MYR\",\"NOK\":\"NOK\",\"NZD\":\"NZD\",\"PLN\":\"PLN\",\"SEK\":\"SEK\",\"SGD\":\"SGD\"}', 0, NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 00:53:10'),
(12, 0, 112, 'Instamojo', 'Instamojo', 1, '{\"api_key\":{\"title\":\"API KEY\",\"global\":true,\"value\":\"test_2241633c3bc44a3de84a3b33969\"},\"auth_token\":{\"title\":\"Auth Token\",\"global\":true,\"value\":\"test_279f083f7bebefd35217feef22d\"},\"salt\":{\"title\":\"Salt\",\"global\":true,\"value\":\"19d38908eeff4f58b2ddda2c6d86ca25\"}}', '{\"INR\":\"INR\"}', 0, NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 02:56:20'),
(13, 0, 501, 'Blockchain', 'Blockchain', 1, '{\"api_key\":{\"title\":\"API Key\",\"global\":true,\"value\":\"55529946-05ca-48ff-8710-f279d86b1cc5\"},\"xpub_code\":{\"title\":\"XPUB CODE\",\"global\":true,\"value\":\"xpub6CKQ3xxWyBoFAF83izZCSFUorptEU9AF8TezhtWeMU5oefjX3sFSBw62Lr9iHXPkXmDQJJiHZeTRtD9Vzt8grAYRhvbz4nEvBu3QKELVzFK\"}}', '{\"BTC\":\"BTC\"}', 1, NULL, NULL, '2019-09-14 13:14:22', '2022-03-21 07:41:56'),
(15, 0, 503, 'CoinPayments', 'Coinpayments', 1, '{\"public_key\":{\"title\":\"Public Key\",\"global\":true,\"value\":\"---------------\"},\"private_key\":{\"title\":\"Private Key\",\"global\":true,\"value\":\"------------\"},\"merchant_id\":{\"title\":\"Merchant ID\",\"global\":true,\"value\":\"93a1e014c4ad60a7980b4a7239673cb4\"}}', '{\"BTC\":\"Bitcoin\",\"BTC.LN\":\"Bitcoin (Lightning Network)\",\"LTC\":\"Litecoin\",\"CPS\":\"CPS Coin\",\"VLX\":\"Velas\",\"APL\":\"Apollo\",\"AYA\":\"Aryacoin\",\"BAD\":\"Badcoin\",\"BCD\":\"Bitcoin Diamond\",\"BCH\":\"Bitcoin Cash\",\"BCN\":\"Bytecoin\",\"BEAM\":\"BEAM\",\"BITB\":\"Bean Cash\",\"BLK\":\"BlackCoin\",\"BSV\":\"Bitcoin SV\",\"BTAD\":\"Bitcoin Adult\",\"BTG\":\"Bitcoin Gold\",\"BTT\":\"BitTorrent\",\"CLOAK\":\"CloakCoin\",\"CLUB\":\"ClubCoin\",\"CRW\":\"Crown\",\"CRYP\":\"CrypticCoin\",\"CRYT\":\"CryTrExCoin\",\"CURE\":\"CureCoin\",\"DASH\":\"DASH\",\"DCR\":\"Decred\",\"DEV\":\"DeviantCoin\",\"DGB\":\"DigiByte\",\"DOGE\":\"Dogecoin\",\"EBST\":\"eBoost\",\"EOS\":\"EOS\",\"ETC\":\"Ether Classic\",\"ETH\":\"Ethereum\",\"ETN\":\"Electroneum\",\"EUNO\":\"EUNO\",\"EXP\":\"EXP\",\"Expanse\":\"Expanse\",\"FLASH\":\"FLASH\",\"GAME\":\"GameCredits\",\"GLC\":\"Goldcoin\",\"GRS\":\"Groestlcoin\",\"KMD\":\"Komodo\",\"LOKI\":\"LOKI\",\"LSK\":\"LSK\",\"MAID\":\"MaidSafeCoin\",\"MUE\":\"MonetaryUnit\",\"NAV\":\"NAV Coin\",\"NEO\":\"NEO\",\"NMC\":\"Namecoin\",\"NVST\":\"NVO Token\",\"NXT\":\"NXT\",\"OMNI\":\"OMNI\",\"PINK\":\"PinkCoin\",\"PIVX\":\"PIVX\",\"POT\":\"PotCoin\",\"PPC\":\"Peercoin\",\"PROC\":\"ProCurrency\",\"PURA\":\"PURA\",\"QTUM\":\"QTUM\",\"RES\":\"Resistance\",\"RVN\":\"Ravencoin\",\"RVR\":\"RevolutionVR\",\"SBD\":\"Steem Dollars\",\"SMART\":\"SmartCash\",\"SOXAX\":\"SOXAX\",\"STEEM\":\"STEEM\",\"STRAT\":\"STRAT\",\"SYS\":\"Syscoin\",\"TPAY\":\"TokenPay\",\"TRIGGERS\":\"Triggers\",\"TRX\":\" TRON\",\"UBQ\":\"Ubiq\",\"UNIT\":\"UniversalCurrency\",\"USDT\":\"Tether USD (Omni Layer)\",\"USDT.BEP20\":\"Tether USD (BSC Chain)\",\"USDT.ERC20\":\"Tether USD (ERC20)\",\"USDT.TRC20\":\"Tether USD (Tron/TRC20)\",\"VTC\":\"Vertcoin\",\"WAVES\":\"Waves\",\"XCP\":\"Counterparty\",\"XEM\":\"NEM\",\"XMR\":\"Monero\",\"XSN\":\"Stakenet\",\"XSR\":\"SucreCoin\",\"XVG\":\"VERGE\",\"XZC\":\"ZCoin\",\"ZEC\":\"ZCash\",\"ZEN\":\"Horizen\"}', 1, NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 02:07:14'),
(16, 0, 504, 'CoinPayments Fiat', 'CoinpaymentsFiat', 1, '{\"merchant_id\":{\"title\":\"Merchant ID\",\"global\":true,\"value\":\"6515561\"}}', '{\"USD\":\"USD\",\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"CLP\":\"CLP\",\"CNY\":\"CNY\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"INR\":\"INR\",\"ISK\":\"ISK\",\"JPY\":\"JPY\",\"KRW\":\"KRW\",\"NZD\":\"NZD\",\"PLN\":\"PLN\",\"RUB\":\"RUB\",\"SEK\":\"SEK\",\"SGD\":\"SGD\",\"THB\":\"THB\",\"TWD\":\"TWD\"}', 0, NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 02:07:44'),
(17, 0, 505, 'Coingate', 'Coingate', 1, '{\"api_key\":{\"title\":\"API Key\",\"global\":true,\"value\":\"6354mwVCEw5kHzRJ6thbGo-N\"}}', '{\"USD\":\"USD\",\"EUR\":\"EUR\"}', 0, NULL, NULL, '2019-09-14 13:14:22', '2022-03-30 09:24:57'),
(18, 0, 506, 'Coinbase Commerce', 'CoinbaseCommerce', 1, '{\"api_key\":{\"title\":\"API Key\",\"global\":true,\"value\":\"c47cd7df-d8e8-424b-a20a\"},\"secret\":{\"title\":\"Webhook Shared Secret\",\"global\":true,\"value\":\"55871878-2c32-4f64-ab66\"}}', '{\"USD\":\"USD\",\"EUR\":\"EUR\",\"JPY\":\"JPY\",\"GBP\":\"GBP\",\"AUD\":\"AUD\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"CNY\":\"CNY\",\"SEK\":\"SEK\",\"NZD\":\"NZD\",\"MXN\":\"MXN\",\"SGD\":\"SGD\",\"HKD\":\"HKD\",\"NOK\":\"NOK\",\"KRW\":\"KRW\",\"TRY\":\"TRY\",\"RUB\":\"RUB\",\"INR\":\"INR\",\"BRL\":\"BRL\",\"ZAR\":\"ZAR\",\"AED\":\"AED\",\"AFN\":\"AFN\",\"ALL\":\"ALL\",\"AMD\":\"AMD\",\"ANG\":\"ANG\",\"AOA\":\"AOA\",\"ARS\":\"ARS\",\"AWG\":\"AWG\",\"AZN\":\"AZN\",\"BAM\":\"BAM\",\"BBD\":\"BBD\",\"BDT\":\"BDT\",\"BGN\":\"BGN\",\"BHD\":\"BHD\",\"BIF\":\"BIF\",\"BMD\":\"BMD\",\"BND\":\"BND\",\"BOB\":\"BOB\",\"BSD\":\"BSD\",\"BTN\":\"BTN\",\"BWP\":\"BWP\",\"BYN\":\"BYN\",\"BZD\":\"BZD\",\"CDF\":\"CDF\",\"CLF\":\"CLF\",\"CLP\":\"CLP\",\"COP\":\"COP\",\"CRC\":\"CRC\",\"CUC\":\"CUC\",\"CUP\":\"CUP\",\"CVE\":\"CVE\",\"CZK\":\"CZK\",\"DJF\":\"DJF\",\"DKK\":\"DKK\",\"DOP\":\"DOP\",\"DZD\":\"DZD\",\"EGP\":\"EGP\",\"ERN\":\"ERN\",\"ETB\":\"ETB\",\"FJD\":\"FJD\",\"FKP\":\"FKP\",\"GEL\":\"GEL\",\"GGP\":\"GGP\",\"GHS\":\"GHS\",\"GIP\":\"GIP\",\"GMD\":\"GMD\",\"GNF\":\"GNF\",\"GTQ\":\"GTQ\",\"GYD\":\"GYD\",\"HNL\":\"HNL\",\"HRK\":\"HRK\",\"HTG\":\"HTG\",\"HUF\":\"HUF\",\"IDR\":\"IDR\",\"ILS\":\"ILS\",\"IMP\":\"IMP\",\"IQD\":\"IQD\",\"IRR\":\"IRR\",\"ISK\":\"ISK\",\"JEP\":\"JEP\",\"JMD\":\"JMD\",\"JOD\":\"JOD\",\"KES\":\"KES\",\"KGS\":\"KGS\",\"KHR\":\"KHR\",\"KMF\":\"KMF\",\"KPW\":\"KPW\",\"KWD\":\"KWD\",\"KYD\":\"KYD\",\"KZT\":\"KZT\",\"LAK\":\"LAK\",\"LBP\":\"LBP\",\"LKR\":\"LKR\",\"LRD\":\"LRD\",\"LSL\":\"LSL\",\"LYD\":\"LYD\",\"MAD\":\"MAD\",\"MDL\":\"MDL\",\"MGA\":\"MGA\",\"MKD\":\"MKD\",\"MMK\":\"MMK\",\"MNT\":\"MNT\",\"MOP\":\"MOP\",\"MRO\":\"MRO\",\"MUR\":\"MUR\",\"MVR\":\"MVR\",\"MWK\":\"MWK\",\"MYR\":\"MYR\",\"MZN\":\"MZN\",\"NAD\":\"NAD\",\"NGN\":\"NGN\",\"NIO\":\"NIO\",\"NPR\":\"NPR\",\"OMR\":\"OMR\",\"PAB\":\"PAB\",\"PEN\":\"PEN\",\"PGK\":\"PGK\",\"PHP\":\"PHP\",\"PKR\":\"PKR\",\"PLN\":\"PLN\",\"PYG\":\"PYG\",\"QAR\":\"QAR\",\"RON\":\"RON\",\"RSD\":\"RSD\",\"RWF\":\"RWF\",\"SAR\":\"SAR\",\"SBD\":\"SBD\",\"SCR\":\"SCR\",\"SDG\":\"SDG\",\"SHP\":\"SHP\",\"SLL\":\"SLL\",\"SOS\":\"SOS\",\"SRD\":\"SRD\",\"SSP\":\"SSP\",\"STD\":\"STD\",\"SVC\":\"SVC\",\"SYP\":\"SYP\",\"SZL\":\"SZL\",\"THB\":\"THB\",\"TJS\":\"TJS\",\"TMT\":\"TMT\",\"TND\":\"TND\",\"TOP\":\"TOP\",\"TTD\":\"TTD\",\"TWD\":\"TWD\",\"TZS\":\"TZS\",\"UAH\":\"UAH\",\"UGX\":\"UGX\",\"UYU\":\"UYU\",\"UZS\":\"UZS\",\"VEF\":\"VEF\",\"VND\":\"VND\",\"VUV\":\"VUV\",\"WST\":\"WST\",\"XAF\":\"XAF\",\"XAG\":\"XAG\",\"XAU\":\"XAU\",\"XCD\":\"XCD\",\"XDR\":\"XDR\",\"XOF\":\"XOF\",\"XPD\":\"XPD\",\"XPF\":\"XPF\",\"XPT\":\"XPT\",\"YER\":\"YER\",\"ZMW\":\"ZMW\",\"ZWL\":\"ZWL\"}\r\n\r\n', 0, '{\"endpoint\":{\"title\": \"Webhook Endpoint\",\"value\":\"ipn.CoinbaseCommerce\"}}', NULL, '2019-09-14 13:14:22', '2021-05-21 02:02:47'),
(24, 0, 113, 'Paypal Express', 'PaypalSdk', 1, '{\"clientId\":{\"title\":\"Paypal Client ID\",\"global\":true,\"value\":\"Ae0-tixtSV7DvLwIh3Bmu7JvHrjh5EfGdXr_cEklKAVjjezRZ747BxKILiBdzlKKyp-W8W_T7CKH1Ken\"},\"clientSecret\":{\"title\":\"Client Secret\",\"global\":true,\"value\":\"EOhbvHZgFNO21soQJT1L9Q00M3rK6PIEsdiTgXRBt2gtGtxwRer5JvKnVUGNU5oE63fFnjnYY7hq3HBA\"}}', '{\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CZK\":\"CZK\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"HKD\":\"HKD\",\"HUF\":\"HUF\",\"INR\":\"INR\",\"ILS\":\"ILS\",\"JPY\":\"JPY\",\"MYR\":\"MYR\",\"MXN\":\"MXN\",\"TWD\":\"TWD\",\"NZD\":\"NZD\",\"NOK\":\"NOK\",\"PHP\":\"PHP\",\"PLN\":\"PLN\",\"GBP\":\"GBP\",\"RUB\":\"RUB\",\"SGD\":\"SGD\",\"SEK\":\"SEK\",\"CHF\":\"CHF\",\"THB\":\"THB\",\"USD\":\"$\"}', 0, NULL, NULL, '2019-09-14 13:14:22', '2021-05-20 23:01:08'),
(25, 0, 114, 'Stripe Checkout', 'StripeV3', 1, '{\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"sk_test_51I6GGiCGv1sRiQlEi5v1or9eR0HVbuzdMd2rW4n3DxC8UKfz66R4X6n4yYkzvI2LeAIuRU9H99ZpY7XCNFC9xMs500vBjZGkKG\"},\"publishable_key\":{\"title\":\"PUBLISHABLE KEY\",\"global\":true,\"value\":\"pk_test_51I6GGiCGv1sRiQlEOisPKrjBqQqqcFsw8mXNaZ2H2baN6R01NulFS7dKFji1NRRxuchoUTEDdB7ujKcyKYSVc0z500eth7otOM\"},\"end_point\":{\"title\":\"End Point Secret\",\"global\":true,\"value\":\"whsec_lUmit1gtxwKTveLnSe88xCSDdnPOt8g5\"}}', '{\"USD\":\"USD\",\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"INR\":\"INR\",\"JPY\":\"JPY\",\"MXN\":\"MXN\",\"MYR\":\"MYR\",\"NOK\":\"NOK\",\"NZD\":\"NZD\",\"PLN\":\"PLN\",\"SEK\":\"SEK\",\"SGD\":\"SGD\"}', 0, '{\"webhook\":{\"title\": \"Webhook Endpoint\",\"value\":\"ipn.StripeV3\"}}', NULL, '2019-09-14 13:14:22', '2021-05-21 00:58:38'),
(27, 0, 115, 'Mollie', 'Mollie', 1, '{\"mollie_email\":{\"title\":\"Mollie Email \",\"global\":true,\"value\":\"vi@gmail.com\"},\"api_key\":{\"title\":\"API KEY\",\"global\":true,\"value\":\"test_cucfwKTWfft9s337qsVfn5CC4vNkrn\"}}', '{\"AED\":\"AED\",\"AUD\":\"AUD\",\"BGN\":\"BGN\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"CZK\":\"CZK\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"HRK\":\"HRK\",\"HUF\":\"HUF\",\"ILS\":\"ILS\",\"ISK\":\"ISK\",\"JPY\":\"JPY\",\"MXN\":\"MXN\",\"MYR\":\"MYR\",\"NOK\":\"NOK\",\"NZD\":\"NZD\",\"PHP\":\"PHP\",\"PLN\":\"PLN\",\"RON\":\"RON\",\"RUB\":\"RUB\",\"SEK\":\"SEK\",\"SGD\":\"SGD\",\"THB\":\"THB\",\"TWD\":\"TWD\",\"USD\":\"USD\",\"ZAR\":\"ZAR\"}', 0, NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 02:44:45'),
(30, 0, 116, 'Cashmaal', 'Cashmaal', 1, '{\"web_id\":{\"title\":\"Web Id\",\"global\":true,\"value\":\"3748\"},\"ipn_key\":{\"title\":\"IPN Key\",\"global\":true,\"value\":\"546254628759524554647987\"}}', '{\"PKR\":\"PKR\",\"USD\":\"USD\"}', 0, '{\"webhook\":{\"title\": \"IPN URL\",\"value\":\"ipn.Cashmaal\"}}', NULL, NULL, '2021-06-22 08:05:04'),
(36, 0, 119, 'Mercado Pago', 'MercadoPago', 1, '{\"access_token\":{\"title\":\"Access Token\",\"global\":true,\"value\":\"3Vee5S2F\"}}', '{\"USD\":\"USD\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"NOK\":\"NOK\",\"PLN\":\"PLN\",\"SEK\":\"SEK\",\"AUD\":\"AUD\",\"NZD\":\"NZD\"}', 0, NULL, NULL, NULL, '2021-07-17 09:44:29'),
(44, 0, 120, 'Authorize.net', 'Authorize', 1, '{\"login_id\":{\"title\":\"Login ID\",\"global\":true,\"value\":\"3Vee5S2F\"},\"transaction_key\":{\"title\":\"Transaction Key\",\"global\":true,\"value\":\"3Vee5S2F\"}}', '{\"USD\":\"USD\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"NOK\":\"NOK\",\"PLN\":\"PLN\",\"SEK\":\"SEK\",\"AUD\":\"AUD\",\"NZD\":\"NZD\"}', 0, NULL, NULL, NULL, '2022-09-15 09:27:31'),
(46, 0, 121, 'NMI', 'NMI', 1, '{\"api_key\":{\"title\":\"API Key\",\"global\":true,\"value\":\"2F822Rw39fx762MaV7Yy86jXGTC7sCDy\"}}', '{\"AED\":\"AED\",\"ARS\":\"ARS\",\"AUD\":\"AUD\",\"BOB\":\"BOB\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"CLP\":\"CLP\",\"CNY\":\"CNY\",\"COP\":\"COP\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"IDR\":\"IDR\",\"ILS\":\"ILS\",\"INR\":\"INR\",\"JPY\":\"JPY\",\"KRW\":\"KRW\",\"MXN\":\"MXN\",\"MYR\":\"MYR\",\"NOK\":\"NOK\",\"NZD\":\"NZD\",\"PEN\":\"PEN\",\"PHP\":\"PHP\",\"PLN\":\"PLN\",\"PYG\":\"PYG\",\"RUB\":\"RUB\",\"SEC\":\"SEC\",\"SGD\":\"SGD\",\"THB\":\"THB\",\"TRY\":\"TRY\",\"TWD\":\"TWD\",\"USD\":\"USD\",\"ZAR\":\"ZAR\"}', 0, NULL, NULL, NULL, '2022-09-10 05:30:15'),
(49, 0, 122, 'BTCPay', 'BTCPay', 1, '{\"store_id\":{\"title\":\"Store Id\",\"global\":true,\"value\":\"-------\"},\"api_key\":{\"title\":\"Api Key\",\"global\":true,\"value\":\"------\"},\"server_name\":{\"title\":\"Server Name\",\"global\":true,\"value\":\"https:\\/\\/yourbtcpaserver.lndyn.com\"},\"secret_code\":{\"title\":\"Secret Code\",\"global\":true,\"value\":\"----------\"}}', '{\"BTC\":\"Bitcoin\",\"LTC\":\"Litecoin\"}', 1, '{\"webhook\":{\"title\": \"IPN URL\",\"value\":\"ipn.BTCPay\"}}', NULL, NULL, NULL),
(50, 0, 123, 'Now payments hosted', 'NowPaymentsHosted', 1, '{\"api_key\":{\"title\":\"API Key\",\"global\":true,\"value\":\"-------------------\"},\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"--------------\"}}', '{\"BTG\":\"BTG\",\"ETH\":\"ETH\",\"XMR\":\"XMR\",\"ZEC\":\"ZEC\",\"XVG\":\"XVG\",\"ADA\":\"ADA\",\"LTC\":\"LTC\",\"BCH\":\"BCH\",\"QTUM\":\"QTUM\",\"DASH\":\"DASH\",\"XLM\":\"XLM\",\"XRP\":\"XRP\",\"XEM\":\"XEM\",\"DGB\":\"DGB\",\"LSK\":\"LSK\",\"DOGE\":\"DOGE\",\"TRX\":\"TRX\",\"KMD\":\"KMD\",\"REP\":\"REP\",\"BAT\":\"BAT\",\"ARK\":\"ARK\",\"WAVES\":\"WAVES\",\"BNB\":\"BNB\",\"XZC\":\"XZC\",\"NANO\":\"NANO\",\"TUSD\":\"TUSD\",\"VET\":\"VET\",\"ZEN\":\"ZEN\",\"GRS\":\"GRS\",\"FUN\":\"FUN\",\"NEO\":\"NEO\",\"GAS\":\"GAS\",\"PAX\":\"PAX\",\"USDC\":\"USDC\",\"ONT\":\"ONT\",\"XTZ\":\"XTZ\",\"LINK\":\"LINK\",\"RVN\":\"RVN\",\"BNBMAINNET\":\"BNBMAINNET\",\"ZIL\":\"ZIL\",\"BCD\":\"BCD\",\"USDT\":\"USDT\",\"USDTERC20\":\"USDTERC20\",\"CRO\":\"CRO\",\"DAI\":\"DAI\",\"HT\":\"HT\",\"WABI\":\"WABI\",\"BUSD\":\"BUSD\",\"ALGO\":\"ALGO\",\"USDTTRC20\":\"USDTTRC20\",\"GT\":\"GT\",\"STPT\":\"STPT\",\"AVA\":\"AVA\",\"SXP\":\"SXP\",\"UNI\":\"UNI\",\"OKB\":\"OKB\",\"BTC\":\"BTC\"}', 1, '', NULL, NULL, '2023-02-14 10:42:09'),
(51, 0, 509, 'Now payments checkout', 'NowPaymentsCheckout', 1, '{\"api_key\":{\"title\":\"API Key\",\"global\":true,\"value\":\"-------------------\"},\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"--------------\"}}', '{\"BTG\":\"BTG\",\"ETH\":\"ETH\",\"XMR\":\"XMR\",\"ZEC\":\"ZEC\",\"XVG\":\"XVG\",\"ADA\":\"ADA\",\"LTC\":\"LTC\",\"BCH\":\"BCH\",\"QTUM\":\"QTUM\",\"DASH\":\"DASH\",\"XLM\":\"XLM\",\"XRP\":\"XRP\",\"XEM\":\"XEM\",\"DGB\":\"DGB\",\"LSK\":\"LSK\",\"DOGE\":\"DOGE\",\"TRX\":\"TRX\",\"KMD\":\"KMD\",\"REP\":\"REP\",\"BAT\":\"BAT\",\"ARK\":\"ARK\",\"WAVES\":\"WAVES\",\"BNB\":\"BNB\",\"XZC\":\"XZC\",\"NANO\":\"NANO\",\"TUSD\":\"TUSD\",\"VET\":\"VET\",\"ZEN\":\"ZEN\",\"GRS\":\"GRS\",\"FUN\":\"FUN\",\"NEO\":\"NEO\",\"GAS\":\"GAS\",\"PAX\":\"PAX\",\"USDC\":\"USDC\",\"ONT\":\"ONT\",\"XTZ\":\"XTZ\",\"LINK\":\"LINK\",\"RVN\":\"RVN\",\"BNBMAINNET\":\"BNBMAINNET\",\"ZIL\":\"ZIL\",\"BCD\":\"BCD\",\"USDT\":\"USDT\",\"USDTERC20\":\"USDTERC20\",\"CRO\":\"CRO\",\"DAI\":\"DAI\",\"HT\":\"HT\",\"WABI\":\"WABI\",\"BUSD\":\"BUSD\",\"ALGO\":\"ALGO\",\"USDTTRC20\":\"USDTTRC20\",\"GT\":\"GT\",\"STPT\":\"STPT\",\"AVA\":\"AVA\",\"SXP\":\"SXP\",\"UNI\":\"UNI\",\"OKB\":\"OKB\",\"BTC\":\"BTC\"}', 1, '', NULL, NULL, '2023-02-14 10:42:09'),
(56, 0, 124, '2Checkout', 'TwoCheckout', 1, '{\"merchant_code\":{\"title\":\"Merchant Code\",\"global\":true,\"value\":\"253248016872\"},\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"eQM)ID@&vG84u!O*g[p+\"}}', '{\"AFN\": \"AFN\",\"ALL\": \"ALL\",\"DZD\": \"DZD\",\"ARS\": \"ARS\",\"AUD\": \"AUD\",\"AZN\": \"AZN\",\"BSD\": \"BSD\",\"BDT\": \"BDT\",\"BBD\": \"BBD\",\"BZD\": \"BZD\",\"BMD\": \"BMD\",\"BOB\": \"BOB\",\"BWP\": \"BWP\",\"BRL\": \"BRL\",\"GBP\": \"GBP\",\"BND\": \"BND\",\"BGN\": \"BGN\",\"CAD\": \"CAD\",\"CLP\": \"CLP\",\"CNY\": \"CNY\",\"COP\": \"COP\",\"CRC\": \"CRC\",\"HRK\": \"HRK\",\"CZK\": \"CZK\",\"DKK\": \"DKK\",\"DOP\": \"DOP\",\"XCD\": \"XCD\",\"EGP\": \"EGP\",\"EUR\": \"EUR\",\"FJD\": \"FJD\",\"GTQ\": \"GTQ\",\"HKD\": \"HKD\",\"HNL\": \"HNL\",\"HUF\": \"HUF\",\"INR\": \"INR\",\"IDR\": \"IDR\",\"ILS\": \"ILS\",\"JMD\": \"JMD\",\"JPY\": \"JPY\",\"KZT\": \"KZT\",\"KES\": \"KES\",\"LAK\": \"LAK\",\"MMK\": \"MMK\",\"LBP\": \"LBP\",\"LRD\": \"LRD\",\"MOP\": \"MOP\",\"MYR\": \"MYR\",\"MVR\": \"MVR\",\"MRO\": \"MRO\",\"MUR\": \"MUR\",\"MXN\": \"MXN\",\"MAD\": \"MAD\",\"NPR\": \"NPR\",\"TWD\": \"TWD\",\"NZD\": \"NZD\",\"NIO\": \"NIO\",\"NOK\": \"NOK\",\"PKR\": \"PKR\",\"PGK\": \"PGK\",\"PEN\": \"PEN\",\"PHP\": \"PHP\",\"PLN\": \"PLN\",\"QAR\": \"QAR\",\"RON\": \"RON\",\"RUB\": \"RUB\",\"WST\": \"WST\",\"SAR\": \"SAR\",\"SCR\": \"SCR\",\"SGD\": \"SGD\",\"SBD\": \"SBD\",\"ZAR\": \"ZAR\",\"KRW\": \"KRW\",\"LKR\": \"LKR\",\"SEK\": \"SEK\",\"CHF\": \"CHF\",\"SYP\": \"SYP\",\"THB\": \"THB\",\"TOP\": \"TOP\",\"TTD\": \"TTD\",\"TRY\": \"TRY\",\"UAH\": \"UAH\",\"AED\": \"AED\",\"USD\": \"USD\",\"VUV\": \"VUV\",\"VND\": \"VND\",\"XOF\": \"XOF\",\"YER\": \"YER\"}', 1, '{\"approved_url\":{\"title\": \"Approved URL\",\"value\":\"ipn.TwoCheckout\"}}', NULL, NULL, '2023-04-29 03:21:58'),
(57, 0, 125, 'Checkout', 'Checkout', 1, '{\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"------\"},\"public_key\":{\"title\":\"PUBLIC KEY\",\"global\":true,\"value\":\"------\"},\"processing_channel_id\":{\"title\":\"PROCESSING CHANNEL\",\"global\":true,\"value\":\"------\"}}', '{\"USD\":\"USD\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"AUD\":\"AUD\",\"CAN\":\"CAN\",\"CHF\":\"CHF\",\"SGD\":\"SGD\",\"JPY\":\"JPY\",\"NZD\":\"NZD\"}', 0, NULL, NULL, NULL, '2023-05-06 01:43:01');

-- --------------------------------------------------------

--
-- Table structure for table `gateway_currencies`
--

CREATE TABLE `gateway_currencies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `symbol` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `method_code` int(10) DEFAULT NULL,
  `gateway_alias` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `min_amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `max_amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `percent_charge` decimal(5,2) NOT NULL DEFAULT 0.00,
  `fixed_charge` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `rate` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway_parameter` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `general_settings`
--

CREATE TABLE `general_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `site_name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cur_text` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'currency text',
  `cur_sym` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'currency symbol',
  `email_from` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_template` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sms_body` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sms_from` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_color` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `secondary_color` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_config` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'email configuration',
  `sms_config` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `global_shortcodes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kv` tinyint(1) NOT NULL DEFAULT 0,
  `ev` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'email verification, 0 - dont check, 1 - check',
  `en` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'email notification, 0 - dont send, 1 - send',
  `sv` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'mobile verication, 0 - dont check, 1 - check',
  `sn` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'sms notification, 0 - dont send, 1 - send',
  `force_ssl` tinyint(1) NOT NULL DEFAULT 0,
  `maintenance_mode` tinyint(1) NOT NULL DEFAULT 0,
  `secure_password` tinyint(1) NOT NULL DEFAULT 0,
  `agree` tinyint(1) NOT NULL DEFAULT 0,
  `registration` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: Off	, 1: On',
  `active_template` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `system_info` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deposit_commission` tinyint(1) NOT NULL DEFAULT 1,
  `invest_commission` tinyint(1) NOT NULL DEFAULT 1,
  `invest_return_commission` tinyint(1) NOT NULL DEFAULT 1,
  `signup_bonus_amount` decimal(11,2) DEFAULT 0.00,
  `signup_bonus_control` tinyint(1) NOT NULL DEFAULT 0,
  `promotional_tool` tinyint(1) NOT NULL DEFAULT 0,
  `firebase_config` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `firebase_template` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `push_notify` tinyint(1) NOT NULL DEFAULT 0,
  `off_day` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_cron` datetime DEFAULT NULL,
  `b_transfer` int(1) NOT NULL DEFAULT 0 COMMENT 'Balance Transfer Status',
  `f_charge` decimal(28,8) NOT NULL DEFAULT 0.00000000 COMMENT 'Fixed Charge',
  `p_charge` decimal(5,2) NOT NULL DEFAULT 0.00 COMMENT 'Percent Charge',
  `user_ranking` tinyint(1) NOT NULL DEFAULT 0,
  `schedule_invest` tinyint(1) NOT NULL DEFAULT 0,
  `holiday_withdraw` tinyint(1) NOT NULL DEFAULT 0,
  `language_switch` tinyint(1) UNSIGNED NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `general_settings`
--

INSERT INTO `general_settings` (`id`, `site_name`, `cur_text`, `cur_sym`, `email_from`, `email_template`, `sms_body`, `sms_from`, `base_color`, `secondary_color`, `mail_config`, `sms_config`, `global_shortcodes`, `kv`, `ev`, `en`, `sv`, `sn`, `force_ssl`, `maintenance_mode`, `secure_password`, `agree`, `registration`, `active_template`, `system_info`, `deposit_commission`, `invest_commission`, `invest_return_commission`, `signup_bonus_amount`, `signup_bonus_control`, `promotional_tool`, `firebase_config`, `firebase_template`, `push_notify`, `off_day`, `last_cron`, `b_transfer`, `f_charge`, `p_charge`, `user_ranking`, `schedule_invest`, `holiday_withdraw`, `language_switch`, `created_at`, `updated_at`) VALUES
(1, 'HYIPLab', 'USD', '$', 'info@viserlab.com', '<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n  <!--[if !mso]><!-->\r\n  <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n  <!--<![endif]-->\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n  <title></title>\r\n  <style type=\"text/css\">\r\n.ReadMsgBody { width: 100%; background-color: #ffffff; }\r\n.ExternalClass { width: 100%; background-color: #ffffff; }\r\n.ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div { line-height: 100%; }\r\nhtml { width: 100%; }\r\nbody { -webkit-text-size-adjust: none; -ms-text-size-adjust: none; margin: 0; padding: 0; }\r\ntable { border-spacing: 0; table-layout: fixed; margin: 0 auto;border-collapse: collapse; }\r\ntable table table { table-layout: auto; }\r\n.yshortcuts a { border-bottom: none !important; }\r\nimg:hover { opacity: 0.9 !important; }\r\na { color: #0087ff; text-decoration: none; }\r\n.textbutton a { font-family: \'open sans\', arial, sans-serif !important;}\r\n.btn-link a { color:#FFFFFF !important;}\r\n\r\n@media only screen and (max-width: 480px) {\r\nbody { width: auto !important; }\r\n*[class=\"table-inner\"] { width: 90% !important; text-align: center !important; }\r\n*[class=\"table-full\"] { width: 100% !important; text-align: center !important; }\r\n/* image */\r\nimg[class=\"img1\"] { width: 100% !important; height: auto !important; }\r\n}\r\n</style>\r\n\r\n\r\n\r\n  <table bgcolor=\"#414a51\" width=\"100%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n    <tbody><tr>\r\n      <td height=\"50\"></td>\r\n    </tr>\r\n    <tr>\r\n      <td align=\"center\" style=\"text-align:center;vertical-align:top;font-size:0;\">\r\n        <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n          <tbody><tr>\r\n            <td align=\"center\" width=\"600\">\r\n              <!--header-->\r\n              <table class=\"table-inner\" width=\"95%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n                <tbody><tr>\r\n                  <td bgcolor=\"#0087ff\" style=\"border-top-left-radius:6px; border-top-right-radius:6px;text-align:center;vertical-align:top;font-size:0;\" align=\"center\">\r\n                    <table width=\"90%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n                      <tbody><tr>\r\n                        <td height=\"20\"></td>\r\n                      </tr>\r\n                      <tr>\r\n                        <td align=\"center\" style=\"font-family: \'Open sans\', Arial, sans-serif; color:#FFFFFF; font-size:16px; font-weight: bold;\">This is a System Generated Email</td>\r\n                      </tr>\r\n                      <tr>\r\n                        <td height=\"20\"></td>\r\n                      </tr>\r\n                    </tbody></table>\r\n                  </td>\r\n                </tr>\r\n              </tbody></table>\r\n              <!--end header-->\r\n              <table class=\"table-inner\" width=\"95%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n                <tbody><tr>\r\n                  <td bgcolor=\"#FFFFFF\" align=\"center\" style=\"text-align:center;vertical-align:top;font-size:0;\">\r\n                    <table align=\"center\" width=\"90%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n                      <tbody><tr>\r\n                        <td height=\"35\"></td>\r\n                      </tr>\r\n                      <!--logo-->\r\n                      <tr>\r\n                        <td align=\"center\" style=\"vertical-align:top;font-size:0;\">\r\n                          <a href=\"#\">\r\n                            <img style=\"display:block; line-height:0px; font-size:0px; border:0px;\" src=\"https://i.imgur.com/Z1qtvtV.png\" alt=\"img\">\r\n                          </a>\r\n                        </td>\r\n                      </tr>\r\n                      <!--end logo-->\r\n                      <tr>\r\n                        <td height=\"40\"></td>\r\n                      </tr>\r\n                      <!--headline-->\r\n                      <tr>\r\n                        <td align=\"center\" style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 22px;color:#414a51;font-weight: bold;\">Hello {{fullname}} ({{username}})</td>\r\n                      </tr>\r\n                      <!--end headline-->\r\n                      <tr>\r\n                        <td align=\"center\" style=\"text-align:center;vertical-align:top;font-size:0;\">\r\n                          <table width=\"40\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n                            <tbody><tr>\r\n                              <td height=\"20\" style=\" border-bottom:3px solid #0087ff;\"></td>\r\n                            </tr>\r\n                          </tbody></table>\r\n                        </td>\r\n                      </tr>\r\n                      <tr>\r\n                        <td height=\"20\"></td>\r\n                      </tr>\r\n                      <!--content-->\r\n                      <tr>\r\n                        <td align=\"left\" style=\"font-family: \'Open sans\', Arial, sans-serif; color:#7f8c8d; font-size:16px; line-height: 28px;\">{{message}}</td>\r\n                      </tr>\r\n                      <!--end content-->\r\n                      <tr>\r\n                        <td height=\"40\"></td>\r\n                      </tr>\r\n              \r\n                    </tbody></table>\r\n                  </td>\r\n                </tr>\r\n                <tr>\r\n                  <td height=\"45\" align=\"center\" bgcolor=\"#f4f4f4\" style=\"border-bottom-left-radius:6px;border-bottom-right-radius:6px;\">\r\n                    <table align=\"center\" width=\"90%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n                      <tbody><tr>\r\n                        <td height=\"10\"></td>\r\n                      </tr>\r\n                      <!--preference-->\r\n                      <tr>\r\n                        <td class=\"preference-link\" align=\"center\" style=\"font-family: \'Open sans\', Arial, sans-serif; color:#95a5a6; font-size:14px;\">\r\n                          © 2021 <a href=\"#\">{{site_name}}</a>&nbsp;. All Rights Reserved. \r\n                        </td>\r\n                      </tr>\r\n                      <!--end preference-->\r\n                      <tr>\r\n                        <td height=\"10\"></td>\r\n                      </tr>\r\n                    </tbody></table>\r\n                  </td>\r\n                </tr>\r\n              </tbody></table>\r\n            </td>\r\n          </tr>\r\n        </tbody></table>\r\n      </td>\r\n    </tr>\r\n    <tr>\r\n      <td height=\"60\"></td>\r\n    </tr>\r\n  </tbody></table>', 'hi {{fullname}} ({{username}}), {{message}}', 'ViserAdmin', '02f400', '', '{\"name\":\"php\"}', '{\"name\":\"nexmo\",\"clickatell\":{\"api_key\":\"----------------\"},\"infobip\":{\"username\":\"------------8888888\",\"password\":\"-----------------\"},\"message_bird\":{\"api_key\":\"-------------------\"},\"nexmo\":{\"api_key\":\"----------------------\",\"api_secret\":\"----------------------\"},\"sms_broadcast\":{\"username\":\"----------------------\",\"password\":\"-----------------------------\"},\"twilio\":{\"account_sid\":\"-----------------------\",\"auth_token\":\"---------------------------\",\"from\":\"----------------------\"},\"text_magic\":{\"username\":\"-----------------------\",\"apiv2_key\":\"-------------------------------\"},\"custom\":{\"method\":\"get\",\"url\":\"https:\\/\\/hostname\\/demo-api-v1\",\"headers\":{\"name\":[\"api_key\"],\"value\":[\"test_api 555\"]},\"body\":{\"name\":[\"from_number\"],\"value\":[\"5657545757\"]}}}', '{\n    \"site_name\":\"Name of your site\",\n    \"site_currency\":\"Currency of your site\",\n    \"currency_symbol\":\"Symbol of currency\"\n}', 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 'neo_dark', '[]', 0, 0, 0, '5.00', 1, 1, NULL, NULL, 0, NULL, '2023-06-24 12:25:08', 1, '5.00000000', '1.00', 1, 1, 0, 1, NULL, '2023-06-24 08:26:34');

-- --------------------------------------------------------

--
-- Table structure for table `holidays`
--

CREATE TABLE `holidays` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invests`
--

CREATE TABLE `invests` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT 0,
  `plan_id` int(10) UNSIGNED DEFAULT 0,
  `amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `initial_amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `interest` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `initial_interest` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `net_interest` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `should_pay` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `paid` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `period` int(11) DEFAULT 0,
  `hours` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time_name` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `return_rec_time` int(11) NOT NULL DEFAULT 0,
  `next_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_time` timestamp NULL DEFAULT NULL,
  `compound_times` int(11) NOT NULL DEFAULT 0,
  `rem_compound_times` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `capital_status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 = YES & 0 = NO',
  `capital_back` tinyint(1) NOT NULL DEFAULT 0,
  `hold_capital` tinyint(1) NOT NULL DEFAULT 0,
  `trx` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `wallet_type` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: not default language, 1: default language',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `name`, `code`, `is_default`, `created_at`, `updated_at`) VALUES
(1, 'English', 'en', 1, '2020-07-06 03:47:55', '2022-04-09 03:47:04');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notification_logs`
--

CREATE TABLE `notification_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `sender` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sent_from` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sent_to` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notification_type` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notification_templates`
--

CREATE TABLE `notification_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `act` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subj` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sms_body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shortcodes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_status` tinyint(1) NOT NULL DEFAULT 1,
  `sms_status` tinyint(1) NOT NULL DEFAULT 1,
  `firebase_status` tinyint(1) NOT NULL DEFAULT 0,
  `firebase_body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notification_templates`
--

INSERT INTO `notification_templates` (`id`, `act`, `name`, `subj`, `email_body`, `sms_body`, `shortcodes`, `email_status`, `sms_status`, `firebase_status`, `firebase_body`, `created_at`, `updated_at`) VALUES
(1, 'BAL_ADD', 'Balance - Added', 'Your Account has been Credited', '<div><div style=\"font-family: Montserrat, sans-serif;\">{{amount}} {{site_currency}} has been added to your account .</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Transaction Number : {{trx}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><span style=\"color: rgb(33, 37, 41); font-family: Montserrat, sans-serif;\">Your Current Balance is :&nbsp;</span><font style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\">{{post_balance}}&nbsp; {{site_currency}}&nbsp;</span></font><br></div><div><font style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></font></div><div>Admin note:&nbsp;<span style=\"color: rgb(33, 37, 41); font-size: 12px; font-weight: 600; white-space: nowrap; text-align: var(--bs-body-text-align);\">{{remark}}</span></div>', '{{amount}} {{site_currency}} credited in your account. Your Current Balance {{post_balance}} {{site_currency}} . Transaction: #{{trx}}. Admin note is \"{{remark}}\"', '{\"trx\":\"Transaction number for the action\",\"amount\":\"Amount inserted by the admin\",\"remark\":\"Remark inserted by the admin\",\"post_balance\":\"Balance of the user after this transaction\"}', 1, 0, 0, NULL, '2021-11-03 12:00:00', '2022-04-03 02:18:28'),
(2, 'BAL_SUB', 'Balance - Subtracted', 'Your Account has been Debited', '<div style=\"font-family: Montserrat, sans-serif;\">{{amount}} {{site_currency}} has been subtracted from your account .</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Transaction Number : {{trx}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><span style=\"color: rgb(33, 37, 41); font-family: Montserrat, sans-serif;\">Your Current Balance is :&nbsp;</span><font style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\">{{post_balance}}&nbsp; {{site_currency}}</span></font><br><div><font style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></font></div><div>Admin Note: {{remark}}</div>', '{{amount}} {{site_currency}} debited from your account. Your Current Balance {{post_balance}} {{site_currency}} . Transaction: #{{trx}}. Admin Note is {{remark}}', '{\"trx\":\"Transaction number for the action\",\"amount\":\"Amount inserted by the admin\",\"remark\":\"Remark inserted by the admin\",\"post_balance\":\"Balance of the user after this transaction\"}', 1, 1, 0, NULL, '2021-11-03 12:00:00', '2022-04-03 02:24:11'),
(3, 'DEPOSIT_COMPLETE', 'Deposit - Automated - Successful', 'Deposit Completed Successfully', '<div>Your deposit of&nbsp;<span style=\"font-weight: bolder;\">{{amount}} {{site_currency}}</span>&nbsp;is via&nbsp;&nbsp;<span style=\"font-weight: bolder;\">{{method_name}}&nbsp;</span>has been completed Successfully.<span style=\"font-weight: bolder;\"><br></span></div><div><span style=\"font-weight: bolder;\"><br></span></div><div><span style=\"font-weight: bolder;\">Details of your Deposit :<br></span></div><div><br></div><div>Amount : {{amount}} {{site_currency}}</div><div>Charge:&nbsp;<font color=\"#000000\">{{charge}} {{site_currency}}</font></div><div><br></div><div>Conversion Rate : 1 {{site_currency}} = {{rate}} {{method_currency}}</div><div>Received : {{method_amount}} {{method_currency}}<br></div><div>Paid via :&nbsp; {{method_name}}</div><div><br></div><div>Transaction Number : {{trx}}</div><div><font size=\"5\"><span style=\"font-weight: bolder;\"><br></span></font></div><div><font size=\"5\">Your current Balance is&nbsp;<span style=\"font-weight: bolder;\">{{post_balance}} {{site_currency}}</span></font></div><div><br style=\"font-family: Montserrat, sans-serif;\"></div>', '{{amount}} {{site_currency}} Deposit successfully by {{method_name}}', '{\"trx\":\"Transaction number for the deposit\",\"amount\":\"Amount inserted by the user\",\"charge\":\"Gateway charge set by the admin\",\"rate\":\"Conversion rate between base currency and method currency\",\"method_name\":\"Name of the deposit method\",\"method_currency\":\"Currency of the deposit method\",\"method_amount\":\"Amount after conversion between base currency and method currency\",\"post_balance\":\"Balance of the user after this transaction\"}', 1, 1, 0, NULL, '2021-11-03 12:00:00', '2022-04-03 02:25:43'),
(4, 'DEPOSIT_APPROVE', 'Deposit - Manual - Approved', 'Your Deposit is Approved', '<div style=\"font-family: Montserrat, sans-serif;\">Your deposit request of&nbsp;<span style=\"font-weight: bolder;\">{{amount}} {{site_currency}}</span>&nbsp;is via&nbsp;&nbsp;<span style=\"font-weight: bolder;\">{{method_name}}&nbsp;</span>is Approved .<span style=\"font-weight: bolder;\"><br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\">Details of your Deposit :<br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Amount : {{amount}} {{site_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">Charge:&nbsp;<font color=\"#FF0000\">{{charge}} {{site_currency}}</font></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Conversion Rate : 1 {{site_currency}} = {{rate}} {{method_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">Received : {{method_amount}} {{method_currency}}<br></div><div style=\"font-family: Montserrat, sans-serif;\">Paid via :&nbsp; {{method_name}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Transaction Number : {{trx}}</div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"5\"><span style=\"font-weight: bolder;\"><br></span></font></div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"5\">Your current Balance is&nbsp;<span style=\"font-weight: bolder;\">{{post_balance}} {{site_currency}}</span></font></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div>', 'Admin Approve Your {{amount}} {{site_currency}} payment request by {{method_name}} transaction : {{trx}}', '{\"trx\":\"Transaction number for the deposit\",\"amount\":\"Amount inserted by the user\",\"charge\":\"Gateway charge set by the admin\",\"rate\":\"Conversion rate between base currency and method currency\",\"method_name\":\"Name of the deposit method\",\"method_currency\":\"Currency of the deposit method\",\"method_amount\":\"Amount after conversion between base currency and method currency\",\"post_balance\":\"Balance of the user after this transaction\"}', 1, 1, 0, NULL, '2021-11-03 12:00:00', '2022-04-03 02:26:07'),
(5, 'DEPOSIT_REJECT', 'Deposit - Manual - Rejected', 'Your Deposit Request is Rejected', '<div style=\"font-family: Montserrat, sans-serif;\">Your deposit request of&nbsp;<span style=\"font-weight: bolder;\">{{amount}} {{site_currency}}</span>&nbsp;is via&nbsp;&nbsp;<span style=\"font-weight: bolder;\">{{method_name}} has been rejected</span>.<span style=\"font-weight: bolder;\"><br></span></div><div><br></div><div><br></div><div style=\"font-family: Montserrat, sans-serif;\">Conversion Rate : 1 {{site_currency}} = {{rate}} {{method_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">Received : {{method_amount}} {{method_currency}}<br></div><div style=\"font-family: Montserrat, sans-serif;\">Paid via :&nbsp; {{method_name}}</div><div style=\"font-family: Montserrat, sans-serif;\">Charge: {{charge}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Transaction Number was : {{trx}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">if you have any queries, feel free to contact us.<br></div><br style=\"font-family: Montserrat, sans-serif;\"><div style=\"font-family: Montserrat, sans-serif;\"><br><br></div><span style=\"color: rgb(33, 37, 41); font-family: Montserrat, sans-serif;\">{{rejection_message}}</span><br>', 'Admin Rejected Your {{amount}} {{site_currency}} payment request by {{method_name}}\r\n\r\n{{rejection_message}}', '{\"trx\":\"Transaction number for the deposit\",\"amount\":\"Amount inserted by the user\",\"charge\":\"Gateway charge set by the admin\",\"rate\":\"Conversion rate between base currency and method currency\",\"method_name\":\"Name of the deposit method\",\"method_currency\":\"Currency of the deposit method\",\"method_amount\":\"Amount after conversion between base currency and method currency\",\"rejection_message\":\"Rejection message by the admin\"}', 1, 1, 0, NULL, '2021-11-03 12:00:00', '2022-04-05 03:45:27'),
(6, 'DEPOSIT_REQUEST', 'Deposit - Manual - Requested', 'Deposit Request Submitted Successfully', '<div>Your deposit request of&nbsp;<span style=\"font-weight: bolder;\">{{amount}} {{site_currency}}</span>&nbsp;is via&nbsp;&nbsp;<span style=\"font-weight: bolder;\">{{method_name}}&nbsp;</span>submitted successfully<span style=\"font-weight: bolder;\">&nbsp;.<br></span></div><div><span style=\"font-weight: bolder;\"><br></span></div><div><span style=\"font-weight: bolder;\">Details of your Deposit :<br></span></div><div><br></div><div>Amount : {{amount}} {{site_currency}}</div><div>Charge:&nbsp;<font color=\"#FF0000\">{{charge}} {{site_currency}}</font></div><div><br></div><div>Conversion Rate : 1 {{site_currency}} = {{rate}} {{method_currency}}</div><div>Payable : {{method_amount}} {{method_currency}}<br></div><div>Pay via :&nbsp; {{method_name}}</div><div><br></div><div>Transaction Number : {{trx}}</div><div><br></div><div><br style=\"font-family: Montserrat, sans-serif;\"></div>', '{{amount}} {{site_currency}} Deposit requested by {{method_name}}. Charge: {{charge}} . Trx: {{trx}}', '{\"trx\":\"Transaction number for the deposit\",\"amount\":\"Amount inserted by the user\",\"charge\":\"Gateway charge set by the admin\",\"rate\":\"Conversion rate between base currency and method currency\",\"method_name\":\"Name of the deposit method\",\"method_currency\":\"Currency of the deposit method\",\"method_amount\":\"Amount after conversion between base currency and method currency\"}', 1, 1, 0, NULL, '2021-11-03 12:00:00', '2022-04-03 02:29:19'),
(7, 'PASS_RESET_CODE', 'Password - Reset - Code', 'Password Reset', '<div style=\"font-family: Montserrat, sans-serif;\">We have received a request to reset the password for your account on&nbsp;<span style=\"font-weight: bolder;\">{{time}} .<br></span></div><div style=\"font-family: Montserrat, sans-serif;\">Requested From IP:&nbsp;<span style=\"font-weight: bolder;\">{{ip}}</span>&nbsp;using&nbsp;<span style=\"font-weight: bolder;\">{{browser}}</span>&nbsp;on&nbsp;<span style=\"font-weight: bolder;\">{{operating_system}}&nbsp;</span>.</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><br style=\"font-family: Montserrat, sans-serif;\"><div style=\"font-family: Montserrat, sans-serif;\"><div>Your account recovery code is:&nbsp;&nbsp;&nbsp;<font size=\"6\"><span style=\"font-weight: bolder;\">{{code}}</span></font></div><div><br></div></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"4\" color=\"#CC0000\">If you do not wish to reset your password, please disregard this message.&nbsp;</font><br></div><div><font size=\"4\" color=\"#CC0000\"><br></font></div>', 'Your account recovery code is: {{code}}', '{\"code\":\"Verification code for password reset\",\"ip\":\"IP address of the user\",\"browser\":\"Browser of the user\",\"operating_system\":\"Operating system of the user\",\"time\":\"Time of the request\"}', 1, 0, 0, NULL, '2021-11-03 12:00:00', '2022-03-20 20:47:05'),
(8, 'PASS_RESET_DONE', 'Password - Reset - Confirmation', 'You have reset your password', '<p style=\"font-family: Montserrat, sans-serif;\">You have successfully reset your password.</p><p style=\"font-family: Montserrat, sans-serif;\">You changed from&nbsp; IP:&nbsp;<span style=\"font-weight: bolder;\">{{ip}}</span>&nbsp;using&nbsp;<span style=\"font-weight: bolder;\">{{browser}}</span>&nbsp;on&nbsp;<span style=\"font-weight: bolder;\">{{operating_system}}&nbsp;</span>&nbsp;on&nbsp;<span style=\"font-weight: bolder;\">{{time}}</span></p><p style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></p><p style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><font color=\"#ff0000\">If you did not change that, please contact us as soon as possible.</font></span></p>', 'Your password has been changed successfully', '{\"ip\":\"IP address of the user\",\"browser\":\"Browser of the user\",\"operating_system\":\"Operating system of the user\",\"time\":\"Time of the request\"}', 1, 1, 0, NULL, '2021-11-03 12:00:00', '2022-04-05 03:46:35'),
(9, 'ADMIN_SUPPORT_REPLY', 'Support - Reply', 'Reply Support Ticket', '<div><p><span data-mce-style=\"font-size: 11pt;\" style=\"font-size: 11pt;\"><span style=\"font-weight: bolder;\">A member from our support team has replied to the following ticket:</span></span></p><p><span style=\"font-weight: bolder;\"><span data-mce-style=\"font-size: 11pt;\" style=\"font-size: 11pt;\"><span style=\"font-weight: bolder;\"><br></span></span></span></p><p><span style=\"font-weight: bolder;\">[Ticket#{{ticket_id}}] {{ticket_subject}}<br><br>Click here to reply:&nbsp; {{link}}</span></p><p>----------------------------------------------</p><p>Here is the reply :<br></p><p>{{reply}}<br></p></div><div><br style=\"font-family: Montserrat, sans-serif;\"></div>', 'Your Ticket#{{ticket_id}} :  {{ticket_subject}} has been replied.', '{\"ticket_id\":\"ID of the support ticket\",\"ticket_subject\":\"Subject  of the support ticket\",\"reply\":\"Reply made by the admin\",\"link\":\"URL to view the support ticket\"}', 1, 1, 0, NULL, '2021-11-03 12:00:00', '2022-03-20 20:47:51'),
(10, 'EVER_CODE', 'Verification - Email', 'Please verify your email address', '<br><div><div style=\"font-family: Montserrat, sans-serif;\">Thanks For joining us.<br></div><div style=\"font-family: Montserrat, sans-serif;\">Please use the below code to verify your email address.<br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Your email verification code is:<font size=\"6\"><span style=\"font-weight: bolder;\">&nbsp;{{code}}</span></font></div></div>', '---', '{\"code\":\"Email verification code\"}', 1, 0, 0, NULL, '2021-11-03 12:00:00', '2022-04-03 02:32:07'),
(11, 'SVER_CODE', 'Verification - SMS', 'Verify Your Mobile Number', '---', 'Your phone verification code is: {{code}}', '{\"code\":\"SMS Verification Code\"}', 0, 1, 0, NULL, '2021-11-03 12:00:00', '2022-03-20 19:24:37'),
(12, 'WITHDRAW_APPROVE', 'Withdraw - Approved', 'Withdraw Request has been Processed and your money is sent', '<div style=\"font-family: Montserrat, sans-serif;\">Your withdraw request of&nbsp;<span style=\"font-weight: bolder;\">{{amount}} {{site_currency}}</span>&nbsp; via&nbsp;&nbsp;<span style=\"font-weight: bolder;\">{{method_name}}&nbsp;</span>has been Processed Successfully.<span style=\"font-weight: bolder;\"><br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\">Details of your withdraw:<br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Amount : {{amount}} {{site_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">Charge:&nbsp;<font color=\"#FF0000\">{{charge}} {{site_currency}}</font></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Conversion Rate : 1 {{site_currency}} = {{rate}} {{method_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">You will get: {{method_amount}} {{method_currency}}<br></div><div style=\"font-family: Montserrat, sans-serif;\">Via :&nbsp; {{method_name}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Transaction Number : {{trx}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">-----</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"4\">Details of Processed Payment :</font></div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"4\"><span style=\"font-weight: bolder;\">{{admin_details}}</span></font></div>', 'Admin Approve Your {{amount}} {{site_currency}} withdraw request by {{method_name}}. Transaction {{trx}}', '{\"trx\":\"Transaction number for the withdraw\",\"amount\":\"Amount requested by the user\",\"charge\":\"Gateway charge set by the admin\",\"rate\":\"Conversion rate between base currency and method currency\",\"method_name\":\"Name of the withdraw method\",\"method_currency\":\"Currency of the withdraw method\",\"method_amount\":\"Amount after conversion between base currency and method currency\",\"admin_details\":\"Details provided by the admin\"}', 1, 1, 0, NULL, '2021-11-03 12:00:00', '2022-03-20 20:50:16'),
(13, 'WITHDRAW_REJECT', 'Withdraw - Rejected', 'Withdraw Request has been Rejected and your money is refunded to your account', '<div style=\"font-family: Montserrat, sans-serif;\">Your withdraw request of&nbsp;<span style=\"font-weight: bolder;\">{{amount}} {{site_currency}}</span>&nbsp; via&nbsp;&nbsp;<span style=\"font-weight: bolder;\">{{method_name}}&nbsp;</span>has been Rejected.<span style=\"font-weight: bolder;\"><br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\">Details of your withdraw:<br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Amount : {{amount}} {{site_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">Charge:&nbsp;<font color=\"#FF0000\">{{charge}} {{site_currency}}</font></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Conversion Rate : 1 {{site_currency}} = {{rate}} {{method_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">You should get: {{method_amount}} {{method_currency}}<br></div><div style=\"font-family: Montserrat, sans-serif;\">Via :&nbsp; {{method_name}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Transaction Number : {{trx}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">----</div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"3\"><br></font></div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"3\">{{amount}} {{currency}} has been&nbsp;<span style=\"font-weight: bolder;\">refunded&nbsp;</span>to your account and your current Balance is&nbsp;<span style=\"font-weight: bolder;\">{{post_balance}}</span><span style=\"font-weight: bolder;\">&nbsp;{{site_currency}}</span></font></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">-----</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"4\">Details of Rejection :</font></div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"4\"><span style=\"font-weight: bolder;\">{{admin_details}}</span></font></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><br><br><br><br><br></div><div></div><div></div>', 'Admin Rejected Your {{amount}} {{site_currency}} withdraw request. Your Main Balance {{post_balance}}  {{method_name}} , Transaction {{trx}}', '{\"trx\":\"Transaction number for the withdraw\",\"amount\":\"Amount requested by the user\",\"charge\":\"Gateway charge set by the admin\",\"rate\":\"Conversion rate between base currency and method currency\",\"method_name\":\"Name of the withdraw method\",\"method_currency\":\"Currency of the withdraw method\",\"method_amount\":\"Amount after conversion between base currency and method currency\",\"post_balance\":\"Balance of the user after fter this action\",\"admin_details\":\"Rejection message by the admin\"}', 1, 1, 0, NULL, '2021-11-03 12:00:00', '2022-03-20 20:57:46'),
(14, 'WITHDRAW_REQUEST', 'Withdraw - Requested', 'Withdraw Request Submitted Successfully', '<div style=\"font-family: Montserrat, sans-serif;\">Your withdraw request of&nbsp;<span style=\"font-weight: bolder;\">{{amount}} {{site_currency}}</span>&nbsp; via&nbsp;&nbsp;<span style=\"font-weight: bolder;\">{{method_name}}&nbsp;</span>has been submitted Successfully.<span style=\"font-weight: bolder;\"><br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\">Details of your withdraw:<br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Amount : {{amount}} {{site_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">Charge:&nbsp;<font color=\"#FF0000\">{{charge}} {{site_currency}}</font></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Conversion Rate : 1 {{site_currency}} = {{rate}} {{method_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">You will get: {{method_amount}} {{method_currency}}<br></div><div style=\"font-family: Montserrat, sans-serif;\">Via :&nbsp; {{method_name}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Transaction Number : {{trx}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"5\">Your current Balance is&nbsp;<span style=\"font-weight: bolder;\">{{post_balance}} {{site_currency}}</span></font></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><br><br><br></div>', '{{amount}} {{site_currency}} withdraw requested by {{method_name}}. You will get {{method_amount}} {{method_currency}} Trx: {{trx}}', '{\"trx\":\"Transaction number for the withdraw\",\"amount\":\"Amount requested by the user\",\"charge\":\"Gateway charge set by the admin\",\"rate\":\"Conversion rate between base currency and method currency\",\"method_name\":\"Name of the withdraw method\",\"method_currency\":\"Currency of the withdraw method\",\"method_amount\":\"Amount after conversion between base currency and method currency\",\"post_balance\":\"Balance of the user after fter this transaction\"}', 1, 1, 0, NULL, '2021-11-03 12:00:00', '2022-03-21 04:39:03'),
(15, 'DEFAULT', 'Default Template', '{{subject}}', '{{message}}', '{{message}}', '{\"subject\":\"Subject\",\"message\":\"Message\"}', 1, 1, 0, NULL, '2019-09-14 13:14:22', '2021-11-04 09:38:55'),
(16, 'KYC_APPROVE', 'KYC Approved', 'KYC has been approved', NULL, NULL, '[]', 1, 1, 0, NULL, NULL, NULL),
(17, 'KYC_REJECT', 'KYC Rejected Successfully', 'KYC has been rejected', NULL, NULL, '[]', 1, 1, 0, NULL, NULL, NULL),
(18, 'INTEREST', 'Interest', 'Interest added to your balance', '<div style=\"font-family: Montserrat, sans-serif;\">You got&nbsp;<span style=\"font-size: 1rem; text-align: var(--bs-body-text-align); font-weight: bolder;\">{{amount}} {{site_currency}}</span><span style=\"color: rgb(33, 37, 41); font-size: 1rem; text-align: var(--bs-body-text-align);\">&nbsp;interest.</span></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\">Details of your Interest:</span></div><div style=\"font-family: Montserrat, sans-serif;\">Amount : {{amount}} {{site_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">Plan Name: {{plan_name}}</div><div style=\"font-family: Montserrat, sans-serif;\">Transaction Number : {{trx}}</div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"5\"><span style=\"font-weight: bolder;\"><br></span></font></div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"5\">Your current Balance is&nbsp;<span style=\"font-weight: bolder;\">{{post_balance}} {{site_currency}}</span></font></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div>', 'You got {{amount}} {{site_currency}} interest. Plan: {{plan_name}}. Trx: {{trx}}', '{\r\n    \"trx\": \"Transaction number for the interest\",\r\n    \"amount\": \"Amount inserted by the user\",\r\n    \"plan_name\": \"Plan name\",\r\n    \"post_balance\": \"Balance of the user after this transaction\"\r\n}', 1, 1, 0, NULL, '2021-11-03 12:00:00', '2022-09-22 06:43:09'),
(19, 'INVESTMENT', 'Investment', 'Investment successfully completed', '<div style=\"font-family: Montserrat, sans-serif;\">Your&nbsp;<span style=\"font-weight: bolder;\">{{amount}} {{site_currency}}</span>&nbsp;investment successfully completed.<span style=\"font-weight: bolder;\"><br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\">Details of your Investment:</span></div><div style=\"font-family: Montserrat, sans-serif;\">Amount : {{amount}} {{site_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"color: rgb(33, 37, 41);\">Wallet type: {{wallet_type}}</span><br></div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"color: rgb(33, 37, 41);\">Plan name: {{plan_name}}</span><br></div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"color: rgb(33, 37, 41);\">Interest: {{interest_amount}} {{site_currency}}</span></div><div style=\"font-family: Montserrat, sans-serif;\">Duration: {{time}}</div><div style=\"font-family: Montserrat, sans-serif;\">Every {{time_name}}</div><div style=\"font-family: Montserrat, sans-serif;\">Transaction Number : {{trx}}</div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"5\"><span style=\"font-weight: bolder;\"><br></span></font></div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"5\">Your current Balance is&nbsp;<span style=\"font-weight: bolder;\">{{post_balance}} {{site_currency}}</span></font></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div>', 'Your {{amount}} {{site_currency}} investment successfully completed. Plan name: {{plan_name}}. Trx: {{trx}}', '{\r\n    \"trx\": \"Transaction number for the interest\",\r\n    \"amount\": \"Amount inserted by the user\",\r\n    \"plan_name\": \"Plan name\",\r\n    \"interest_amount\": \"Interest amount\",\r\n    \"time\": \"Plan duration\",\r\n    \"time_name\": \"Interest duration\",\r\n    \"wallet_type\": \"Invest wallet\",\r\n    \"post_balance\": \"Balance of the user after this transaction\"\r\n}', 1, 1, 0, NULL, '2021-11-03 12:00:00', '2022-09-22 06:26:23'),
(20, 'REFERRAL_COMMISSION', 'Referral Commission', 'Referral Commission', '<div style=\"font-family: Montserrat, sans-serif;\">You got&nbsp;<span style=\"font-weight: bolder;\">{{amount}} {{site_currency}}</span>&nbsp;referral commission.</div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\">Details of your referral commission:</span></div><div style=\"font-family: Montserrat, sans-serif;\">Amount : {{amount}} {{site_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">{{type}} referral commission</div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"color: rgb(33, 37, 41);\">Transaction Number : {{trx}}</span><br></div><div style=\"font-family: Montserrat, sans-serif;\">{{level}} level referral commission.</div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"5\"><span style=\"font-weight: bolder;\"><br></span></font></div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"5\">Your current Balance is&nbsp;<span style=\"font-weight: bolder;\">{{post_balance}} {{site_currency}}</span></font></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div>', 'Your got {{amount}} {{site_currency}} referral commission from {{ref_username}}.', '{\r\n    \"trx\": \"Transaction number for the interest\",\r\n    \"amount\": \"Amount inserted by the user\",\r\n    \"plan_name\": \"Plan name\",\r\n    \"level\": \"Which level referral commission\",\r\n    \"post_balance\": \"Balance of the user after this transaction\"\r\n}', 1, 1, 0, NULL, '2021-11-03 12:00:00', '2022-09-22 03:43:49'),
(21, 'REFERRAL_JOIN', 'Referral Join', 'Referral Join', '<div style=\"font-family: Montserrat, sans-serif;\">@{{ref_username}} has been joined by your referral link.</div>', '{{ref_user_name}} ({{ref_username}}) has been joined by your referral link.', '{\r\n    \"ref_user_name\": \"Referral user full name\",\r\n    \"ref_username\": \"Referral user username\"\r\n}', 1, 1, 0, NULL, '2021-11-03 12:00:00', '2022-09-22 05:05:46'),
(22, 'BALANCE_TRANSFER', 'Balance Transfer', 'Balance Transfer', '<div style=\"font-family: Montserrat, sans-serif;\">Your&nbsp;<span style=\"font-weight: bolder;\">{{amount}} {{site_currency}}</span>&nbsp;transferred successfully.<span style=\"font-weight: bolder;\"><br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\">Details of your Transfer:</span></div><div style=\"font-family: Montserrat, sans-serif;\">Amount : {{amount}} {{site_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">Charge:&nbsp;<font color=\"#FF0000\">{{charge}} {{site_currency}}</font></div><div style=\"\"><font face=\"Montserrat, sans-serif\">Wallet type: {{wallet_type}}</font></div><div style=\"\"><font face=\"Montserrat, sans-serif\">Transfer to: {{user_fullname}} (</font><span style=\"color: rgb(33, 37, 41); font-family: Montserrat, sans-serif; font-size: 1rem; text-align: var(--bs-body-text-align);\">{{username}})</span></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Transaction Number : {{trx}}</div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"5\"><span style=\"font-weight: bolder;\"><br></span></font></div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"5\">Your current Balance is&nbsp;<span style=\"font-weight: bolder;\">{{post_balance}} {{site_currency}}</span></font></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div>', 'Your {{amount}} {{site_currency}} transferred successfully. Transfer to: {{user_fullname}} ({{username}})', '{\r\n{\r\n    \"trx\": \"Transaction number for the interest\",\r\n    \"amount\": \"Amount inserted by the user\",\r\n    \"wallet_type\": \"Wallet type\",\r\n    \"charge\": \"Charge amount\",\r\n    \"user_fullname\": \"Transfer user full name\",\r\n    \"username\": \"Transfer user username\",\r\n    \"post_balance\": \"Balance of the user after this transaction\"\r\n}\r\n    \"amount\": \"Amount inserted by the user\",\r\n    \"charge\": \"Charge amount\",\r\n    \"user_fullname\": \"Transfer user full name\",\r\n    \"username\": \"Transfer user username\",\r\n    \"post_balance\": \"Balance of the user after this transaction\"\r\n}\r\n', 1, 1, 0, NULL, '2021-11-03 12:00:00', '2022-09-22 05:09:03'),
(23, 'BALANCE_RECEIVE', 'Balance Receive', 'Balance Receive', '<div style=\"font-family: Montserrat, sans-serif;\">You received&nbsp;<span style=\"font-weight: bolder;\">{{amount}} {{site_currency}}</span>&nbsp;from {{sender}}.<span style=\"font-weight: bolder;\"><br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\">Details of your Received Money:</span></div><div style=\"font-family: Montserrat, sans-serif;\">Amount : {{amount}} {{site_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">Wallet_type: {{wallet_type}}</div><div style=\"font-family: Montserrat, sans-serif;\">Transaction Number : {{trx}}</div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"5\"><span style=\"font-weight: bolder;\"><br></span></font></div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"5\">Your current Balance is&nbsp;<span style=\"font-weight: bolder;\">{{post_balance}} {{site_currency}}</span></font></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div>', 'Your {{amount}} {{site_currency}} transferred successfully. Transfer to: {{user_fullname}} ({{username}})', '{\r\n    \"trx\": \"Transaction number for the interest\",\r\n    \"amount\": \"Amount inserted by the user\",\r\n    \"sender\": \"Sender username\",\r\n    \"wallet_type\": \"Wallet type\",\r\n    \"post_balance\": \"Balance of the user after this transaction\"\r\n}\r\n', 1, 1, 0, NULL, '2021-11-03 12:00:00', '2022-09-20 09:03:25'),
(24, 'INSUFFICIENT_BALANCE', 'Schedule Investment Failed', 'Schedule Investment Failed', '<div style=\"font-family: Montserrat, sans-serif;\">Your scheduled investment failed due to insufficient balance.</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Details of your scheduled investment.</div><div style=\"font-family: Montserrat, sans-serif;\">Invest Amount: {{invest_amount}} {{site_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">Wallet: {{wallet}}</div><div style=\"font-family: Montserrat, sans-serif;\">Plan Name: {{plan_name}}</div><div style=\"font-family: Montserrat, sans-serif;\">Your Balance: {{balance}} {{site_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">Next Schedule: {{next_schedule}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Please keep your balance for the next scheduled date.</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div>', 'Your scheduled investment failed due to insufficient balance.', '{\r\n    \"invest_amount\": \"Invest amount\",\r\n    \"wallet\": \"Wallet type\",\r\n    \"plan_name\": \"Plan name\",\r\n    \"balance\": \"User balance\",\r\n    \"next_schedule\": \"Next invest schedule\"\r\n}', 1, 0, 0, 'Your scheduled investment failed due to insufficient balance.', '2021-11-03 12:00:00', '2023-06-21 03:13:36');

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tempname` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'template name',
  `secs` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `name`, `slug`, `tempname`, `secs`, `is_default`, `created_at`, `updated_at`) VALUES
(1, 'HOME', '/', 'templates.bit_gold.', '[\"about\",\"plan\",\"why_choose\",\"calculation\",\"how_work\",\"faq\",\"testimonial\",\"team\",\"transaction\",\"top_investor\",\"cta\",\"we_accept\",\"ranking\",\"blog\",\"subscribe\"]', 1, '2020-07-11 06:23:58', '2023-06-21 06:27:07'),
(4, 'Blog', 'blogs', 'templates.bit_gold.', NULL, 1, '2020-10-22 01:14:43', '2022-09-10 04:36:20'),
(5, 'Contact', 'contact', 'templates.bit_gold.', NULL, 1, '2020-10-22 01:14:53', '2020-10-22 01:14:53'),
(19, 'Plans', 'plans', 'templates.bit_gold.', NULL, 1, '2022-05-18 09:37:02', '2022-05-18 09:38:21'),
(20, 'Home', '/', 'templates.neo_dark.', '[\"about\",\"faq\",\"why_choose\",\"plan\",\"subscribe\",\"testimonial\",\"top_investor\",\"transaction\",\"calculation\",\"ranking\",\"how_work\",\"blog\"]', 1, '2022-06-06 08:34:19', '2023-06-21 06:22:47'),
(21, 'Plan', 'plans', 'templates.neo_dark.', NULL, 1, '2022-06-11 08:26:40', '2022-06-11 08:27:13'),
(22, 'About', 'about', 'templates.neo_dark.', '[\"how_work\",\"about\",\"counter\",\"team\",\"we_accept\"]', 0, '2022-06-11 08:55:56', '2022-06-11 09:06:05'),
(23, 'Blogs', 'blogs', 'templates.neo_dark.', NULL, 1, '2022-06-11 09:34:38', '2022-06-11 09:34:38'),
(24, 'About', 'about', 'templates.bit_gold.', '[\"how_work\",\"about\",\"faq\",\"cta\"]', 0, '2022-08-25 04:50:42', '2022-08-25 04:52:26'),
(25, 'Home', '/', 'templates.invester.', NULL, 1, '2022-09-20 07:12:38', '2022-09-20 07:13:53');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `plans`
--

CREATE TABLE `plans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `time_setting_id` int(10) NOT NULL DEFAULT 0,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `minimum` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `maximum` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `fixed_amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `interest` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `interest_type` tinyint(1) DEFAULT 0 COMMENT '1 = ''%'' / 0 =''currency''',
  `repeat_time` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lifetime` tinyint(1) DEFAULT 0,
  `capital_back` tinyint(1) DEFAULT 0,
  `compound_interest` tinyint(1) NOT NULL DEFAULT 0,
  `hold_capital` tinyint(1) NOT NULL DEFAULT 0,
  `featured` tinyint(1) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `promotion_tools`
--

CREATE TABLE `promotion_tools` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `banner` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `referrals`
--

CREATE TABLE `referrals` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `commission_type` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `level` int(11) NOT NULL DEFAULT 0,
  `percent` decimal(5,2) NOT NULL DEFAULT 0.00,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `schedule_invests`
--

CREATE TABLE `schedule_invests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `plan_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `wallet` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `schedule_times` int(11) NOT NULL DEFAULT 0,
  `rem_schedule_times` int(11) NOT NULL DEFAULT 0,
  `interval_hours` int(11) NOT NULL DEFAULT 0,
  `compound_times` int(11) NOT NULL DEFAULT 0,
  `next_invest` datetime DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscribers`
--

CREATE TABLE `subscribers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `support_attachments`
--

CREATE TABLE `support_attachments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `support_message_id` int(10) UNSIGNED DEFAULT NULL,
  `attachment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `support_messages`
--

CREATE TABLE `support_messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `support_ticket_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `admin_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `message` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `support_tickets`
--

CREATE TABLE `support_tickets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) DEFAULT 0,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ticket` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: Open, 1: Answered, 2: Replied, 3: Closed',
  `priority` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 = Low, 2 = medium, 3 = heigh',
  `last_reply` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `time_settings`
--

CREATE TABLE `time_settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0: Disable\r\n1: Enable',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `invest_id` int(10) NOT NULL DEFAULT 0,
  `amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `charge` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `post_balance` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `trx_type` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trx` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remark` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `wallet_type` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `update_logs`
--

CREATE TABLE `update_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `version` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_log` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `firstname` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_code` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ref_by` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `deposit_wallet` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `interest_wallet` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_invests` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `team_invests` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `user_ranking_id` int(10) NOT NULL DEFAULT 0,
  `address` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'contains full address',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0: banned, 1: active',
  `kyc_data` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kv` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: KYC Unverified, 2: KYC pending, 1: KYC verified',
  `ev` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: email unverified, 1: email verified',
  `sv` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: mobile unverified, 1: mobile verified',
  `profile_complete` tinyint(1) NOT NULL DEFAULT 0,
  `ver_code` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'stores verification code',
  `ver_code_send_at` datetime DEFAULT NULL COMMENT 'verification send time',
  `ts` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: 2fa off, 1: 2fa on',
  `tv` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0: 2fa unverified, 1: 2fa verified',
  `tsc` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ban_reason` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_rank_update` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_logins`
--

CREATE TABLE `user_logins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `user_ip` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_code` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `browser` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `os` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_rankings`
--

CREATE TABLE `user_rankings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `level` int(11) DEFAULT 0,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `minimum_invest` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `min_referral_invest` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `min_referral` int(11) NOT NULL DEFAULT 0,
  `bonus` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `withdrawals`
--

CREATE TABLE `withdrawals` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `method_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `currency` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rate` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `charge` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `trx` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `final_amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `after_charge` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `withdraw_information` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1=>success, 2=>pending, 3=>cancel,  ',
  `admin_feedback` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `withdraw_methods`
--

CREATE TABLE `withdraw_methods` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `form_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `min_limit` decimal(28,8) DEFAULT 0.00000000,
  `max_limit` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `fixed_charge` decimal(28,8) DEFAULT 0.00000000,
  `rate` decimal(28,8) DEFAULT 0.00000000,
  `percent_charge` decimal(5,2) DEFAULT 0.00,
  `currency` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`,`username`);

--
-- Indexes for table `admin_notifications`
--
ALTER TABLE `admin_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_password_resets`
--
ALTER TABLE `admin_password_resets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cron_jobs`
--
ALTER TABLE `cron_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cron_job_logs`
--
ALTER TABLE `cron_job_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cron_schedules`
--
ALTER TABLE `cron_schedules`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deposits`
--
ALTER TABLE `deposits`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `device_tokens`
--
ALTER TABLE `device_tokens`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `extensions`
--
ALTER TABLE `extensions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `forms`
--
ALTER TABLE `forms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `frontends`
--
ALTER TABLE `frontends`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gateways`
--
ALTER TABLE `gateways`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `gateway_currencies`
--
ALTER TABLE `gateway_currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `general_settings`
--
ALTER TABLE `general_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `holidays`
--
ALTER TABLE `holidays`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invests`
--
ALTER TABLE `invests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notification_logs`
--
ALTER TABLE `notification_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notification_templates`
--
ALTER TABLE `notification_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `plans`
--
ALTER TABLE `plans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `promotion_tools`
--
ALTER TABLE `promotion_tools`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `referrals`
--
ALTER TABLE `referrals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `schedule_invests`
--
ALTER TABLE `schedule_invests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscribers`
--
ALTER TABLE `subscribers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `support_attachments`
--
ALTER TABLE `support_attachments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `support_messages`
--
ALTER TABLE `support_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `support_tickets`
--
ALTER TABLE `support_tickets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `time_settings`
--
ALTER TABLE `time_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `update_logs`
--
ALTER TABLE `update_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`,`email`);

--
-- Indexes for table `user_logins`
--
ALTER TABLE `user_logins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_rankings`
--
ALTER TABLE `user_rankings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `withdrawals`
--
ALTER TABLE `withdrawals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `withdraw_methods`
--
ALTER TABLE `withdraw_methods`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `admin_notifications`
--
ALTER TABLE `admin_notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin_password_resets`
--
ALTER TABLE `admin_password_resets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cron_jobs`
--
ALTER TABLE `cron_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `cron_job_logs`
--
ALTER TABLE `cron_job_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cron_schedules`
--
ALTER TABLE `cron_schedules`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `deposits`
--
ALTER TABLE `deposits`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `device_tokens`
--
ALTER TABLE `device_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `extensions`
--
ALTER TABLE `extensions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `forms`
--
ALTER TABLE `forms`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `frontends`
--
ALTER TABLE `frontends`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=418;

--
-- AUTO_INCREMENT for table `gateways`
--
ALTER TABLE `gateways`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `gateway_currencies`
--
ALTER TABLE `gateway_currencies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `general_settings`
--
ALTER TABLE `general_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `holidays`
--
ALTER TABLE `holidays`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invests`
--
ALTER TABLE `invests`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notification_logs`
--
ALTER TABLE `notification_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notification_templates`
--
ALTER TABLE `notification_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `plans`
--
ALTER TABLE `plans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `promotion_tools`
--
ALTER TABLE `promotion_tools`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `referrals`
--
ALTER TABLE `referrals`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `schedule_invests`
--
ALTER TABLE `schedule_invests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscribers`
--
ALTER TABLE `subscribers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `support_attachments`
--
ALTER TABLE `support_attachments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `support_messages`
--
ALTER TABLE `support_messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `support_tickets`
--
ALTER TABLE `support_tickets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `time_settings`
--
ALTER TABLE `time_settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `update_logs`
--
ALTER TABLE `update_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_logins`
--
ALTER TABLE `user_logins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_rankings`
--
ALTER TABLE `user_rankings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `withdrawals`
--
ALTER TABLE `withdrawals`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `withdraw_methods`
--
ALTER TABLE `withdraw_methods`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;


ALTER TABLE `general_settings` ADD `system_customized` TINYINT(1) NOT NULL DEFAULT '0' AFTER `system_info`;

ALTER TABLE `general_settings` ADD `staking_option` TINYINT(1) NOT NULL DEFAULT '0' AFTER `holiday_withdraw`, ADD `staking_min_amount` DECIMAL(28,8) NOT NULL DEFAULT '0' AFTER `staking_option`, ADD `staking_max_amount` DECIMAL(28,8) NOT NULL DEFAULT '0' AFTER `staking_min_amount`;

ALTER TABLE `general_settings` ADD `pool_option` TINYINT(1) NOT NULL DEFAULT '0' AFTER `staking_max_amount`;


ALTER TABLE `invests` CHANGE `status` `status` TINYINT(1) NOT NULL DEFAULT '1' COMMENT '0: Closed\r\n1: Running\r\n2: Canceled';
ALTER TABLE `invests` CHANGE `next_time` `next_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE `users` ADD `wallet` VARCHAR(255) NULL DEFAULT NULL AFTER `email`;
ALTER TABLE `users` ADD `message` VARCHAR(40) NULL DEFAULT NULL AFTER `wallet`;

ALTER TABLE `deposits` ADD `compound_times` INT(11) NOT NULL DEFAULT '0' AFTER `trx`;


INSERT INTO `cron_jobs` (`name`, `alias`, `action`, `url`, `cron_schedule_id`, `next_run`, `last_run`, `is_running`, `is_default`, `created_at`, `updated_at`) VALUES ('Staking Invest', 'staking_invest', '[\"App\\\\Http\\\\Controllers\\\\CronController\", \"staking\"]', NULL, '1', '2023-07-26 18:55:58', '2023-07-26 18:50:58', '1', '1', '2023-06-22 12:10:31', '2023-07-26 18:50:58');


CREATE TABLE `pools` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `invested_amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `start_date` timestamp NULL DEFAULT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  `interest_range` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `share_interest` tinyint(4) NOT NULL DEFAULT 0,
  `interest` decimal(5,2) NOT NULL DEFAULT 0.00,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `pool_invests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `pool_id` int(10) UNSIGNED NOT NULL,
  `invest_amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '1: Running\r\n2: Completed\r\n',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `stakings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `days` int(11) NOT NULL,
  `interest_percent` decimal(5,2) NOT NULL DEFAULT 0.00,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


CREATE TABLE `staking_invests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `staking_id` int(10) NOT NULL DEFAULT 0,
  `invest_amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `interest` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `end_at` datetime DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1: Running\r\n2: Completed',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



ALTER TABLE `pools`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `pool_invests`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `stakings`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `staking_invests`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `pools`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `pool_invests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `stakings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `staking_invests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
