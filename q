[1mdiff --git a/app/controllers/error_data_controller.rb b/app/controllers/error_data_controller.rb[m
[1mindex 171471b..a298a14 100644[m
[1m--- a/app/controllers/error_data_controller.rb[m
[1m+++ b/app/controllers/error_data_controller.rb[m
[36m@@ -5,7 +5,7 @@[m [mclass ErrorDataController < ApplicationController[m
         # begin[m
         #     1 * '10'[m
         # rescue StandardError => e[m
[31m-        #     render plain: "Its StandardError: #{e.message}", status: :internal_server_error[m
[32m+[m[32m        #     render plain: "Its StandardError: #{e.message}"[m
         # end[m
 [m
         #Active Record Not Found[m
[36m@@ -44,17 +44,20 @@[m [mclass ErrorDataController < ApplicationController[m
         #   result = Rails.error.handle do[m
         #     1 + '1'[m
         #   end[m
[31m-        #   render plain: result[m
[32m+[m[32m        #   render plain: "sdfsdfs #{result}"[m
         # rescue TypeError => e[m
         #     render plain: "TypeError occurred: #{e.message}"[m
         # end[m
 [m
         #fallback error -? if user not found then this wil take User.last[m
[31m-        # user = Rails.error.handle(fallback: -> { User.last }) do[m
[31m-        #   User.find(10)[m
[31m-        # end[m
[31m-        # render plain: user&.name[m
[32m+[m[32m        user = Rails.error.handle(fallback: -> { User.last }) do[m
[32m+[m[32m          User.find(10)[m
[32m+[m[32m        end[m
[32m+[m[32m        render plain: user&.name[m
[32m+[m
[32m+[m[32m    end[m
 [m
[32m+[m[32m    def not_found[m
     end[m
 [m
     def argument_error_generator[m
[1mdiff --git a/config/application.rb b/config/application.rb[m
[1mindex 4621e0b..3a6289b 100644[m
[1m--- a/config/application.rb[m
[1m+++ b/config/application.rb[m
[36m@@ -11,6 +11,8 @@[m [mmodule Demo123[m
     # Initialize configuration defaults for originally generated Rails version.[m
     config.load_defaults 7.1[m
 [m
[32m+[m[32m    config.exceptions_app = ->(env) { ErrorsController.action(:show).call(env) }[m
[32m+[m
     config.logger = CustomLogger.new(STDOUT)[m
 [m
     # Please, add to the `ignore` list any other `lib` subdirectories that do[m
[1mdiff --git a/config/environments/development.rb b/config/environments/development.rb[m
[1mindex fd345c4..c95db99 100644[m
[1m--- a/config/environments/development.rb[m
[1m+++ b/config/environments/development.rb[m
[36m@@ -12,11 +12,10 @@[m [mRails.application.configure do[m
   config.eager_load = false[m
 [m
   # Show full error reports.[m
[31m-  config.consider_all_requests_local = true[m
[32m+[m[32m  config.consider_all_requests_local = false[m
 [m
   # Enable server timing[m
   config.server_timing = true[m
[31m-  config.hosts << "dee7-2405-201-2017-3869-783c-a0c8-37de-709f.ngrok-free.app"[m
 [m
   # Enable/disable caching. By default caching is disabled.[m
   # Run rails dev:cache to toggle caching.[m
[1mdiff --git a/public/404.html b/public/404.html[m
[1mdeleted file mode 100644[m
[1mindex 2be3af2..0000000[m
[1m--- a/public/404.html[m
[1m+++ /dev/null[m
[36m@@ -1,67 +0,0 @@[m
[31m-<!DOCTYPE html>[m
[31m-<html>[m
[31m-<head>[m
[31m-  <title>The page you were looking for doesn't exist (404)</title>[m
[31m-  <meta name="viewport" content="width=device-width,initial-scale=1">[m
[31m-  <style>[m
[31m-  .rails-default-error-page {[m
[31m-    background-color: #EFEFEF;[m
[31m-    color: #2E2F30;[m
[31m-    text-align: center;[m
[31m-    font-family: arial, sans-serif;[m
[31m-    margin: 0;[m
[31m-  }[m
[31m-[m
[31m-  .rails-default-error-page div.dialog {[m
[31m-    width: 95%;[m
[31m-    max-width: 33em;[m
[31m-    margin: 4em auto 0;[m
[31m-  }[m
[31m-[m
[31m-  .rails-default-error-page div.dialog > div {[m
[31m-    border: 1px solid #CCC;[m
[31m-    border-right-color: #999;[m
[31m-    border-left-color: #999;[m
[31m-    border-bottom-color: #BBB;[m
[31m-    border-top: #B00100 solid 4px;[m
[31m-    border-top-left-radius: 9px;[m
[31m-    border-top-right-radius: 9px;[m
[31m-    background-color: white;[m
[31m-    padding: 7px 12% 0;[m
[31m-    box-shadow: 0 3px 8px rgba(50, 50, 50, 0.17);[m
[31m-  }[m
[31m-[m
[31m-  .rails-default-error-page h1 {[m
[31m-    font-size: 100%;[m
[31m-    color: #730E15;[m
[31m-    line-height: 1.5em;[m
[31m-  }[m
[31m-[m
[31m-  .rails-default-error-page div.dialog > p {[m
[31m-    margin: 0 0 1em;[m
[31m-    padding: 1em;[m
[31m-    background-color: #F7F7F7;[m
[31m-    border: 1px solid #CCC;[m
[31m-    border-right-color: #999;[m
[31m-    border-left-color: #999;[m
[31m-    border-bottom-color: #999;[m
[31m-    border-bottom-left-radius: 4px;[m
[31m-    border-bottom-right-radius: 4px;[m
[31m-    border-top-color: #DADADA;[m
[31m-    color: #666;[m
[31m-    box-shadow: 0 3px 8px rgba(50, 50, 50, 0.17);[m
[31m-  }[m
[31m-  </style>[m
[31m-</head>[m
[31m-[m
[31m-<body class="rails-default-error-page">[m
[31m-  <!-- This file lives in public/404.html -->[m
[31m-  <div class="dialog">[m
[31m-    <div>[m
[31m-      <h1>The page you were looking for doesn't exist.</h1>[m
[31m-      <p>You may have mistyped the address or the page may have moved.</p>[m
[31m-    </div>[m
[31m-    <p>If you are the application owner check the logs for more information.</p>[m
[31m-  </div>[m
[31m-</body>[m
[31m-</html>[m
[1mdiff --git a/public/422.html b/public/422.html[m
[1mdeleted file mode 100644[m
[1mindex c08eac0..0000000[m
[1m--- a/public/422.html[m
[1m+++ /dev/null[m
[36m@@ -1,67 +0,0 @@[m
[31m-<!DOCTYPE html>[m
[31m-<html>[m
[31m-<head>[m
[31m-  <title>The change you wanted was rejected (422)</title>[m
[31m-  <meta name="viewport" content="width=device-width,initial-scale=1">[m
[31m-  <style>[m
[31m-  .rails-default-error-page {[m
[31m-    background-color: #EFEFEF;[m
[31m-    color: #2E2F30;[m
[31m-    text-align: center;[m
[31m-    font-family: arial, sans-serif;[m
[31m-    margin: 0;[m
[31m-  }[m
[31m-[m
[31m-  .rails-default-error-page div.dialog {[m
[31m-    width: 95%;[m
[31m-    max-width: 33em;[m
[31m-    margin: 4em auto 0;[m
[31m-  }[m
[31m-[m
[31m-  .rails-default-error-page div.dialog > div {[m
[31m-    border: 1px solid #CCC;[m
[31m-    border-right-color: #999;[m
[31m-    border-left-color: #999;[m
[31m-    border-bottom-color: #BBB;[m
[31m-    border-top: #B00100 solid 4px;[m
[31m-    border-top-left-radius: 9px;[m
[31m-    border-top-right-radius: 9px;[m
[31m-    background-color: white;[m
[31m-    padding: 7px 12% 0;[m
[31m-    box-shadow: 0 3px 8px rgba(50, 50, 50, 0.17);[m
[31m-  }[m
[31m-[m
[31m-  .rails-default-error-page h1 {[m
[31m-    font-size: 100%;[m
[31m-    color: #730E15;[m
[31m-    line-height: 1.5em;[m
[31m-  }[m
[31m-[m
[31m-  .rails-default-error-page div.dialog > p {[m
[31m-    margin: 0 0 1em;[m
[31m-    padding: 1em;[m
[31m-    background-color: #F7F7F7;[m
[31m-    border: 1px solid #CCC;[m
[31m-    border-right-color: #999;[m
[31m-    border-left-color: #999;[m
[31m-    border-bottom-color: #999;[m
[31m-    border-bottom-left-radius: 4px;[m
[31m-    border-bottom-right-radius: 4px;[m
[31m-    border-top-color: #DADADA;[m
[31m-    color: #666;[m
[31m-    box-shadow: 0 3px 8px rgba(50, 50, 50, 0.17);[m
[31m-  }[m
[31m-  </style>[m
[31m-</head>[m
[31m-[m
[31m-<body class="rails-default-error-page">[m
[31m-  <!-- This file lives in public/422.html -->[m
[31m-  <div class="dialog">[m
[31m-    <div>[m
[31m-      <h1>The change you wanted was rejected.</h1>[m
[31m-      <p>Maybe you tried to change something you didn't have access to.</p>[m
[31m-    </div>[m
[31m-    <p>If you are the application owner check the logs for more information.</p>[m
[31m-  </div>[m
[31m-</body>[m
[31m-</html>[m
[1mdiff --git a/public/500.html b/public/500.html[m
[1mdeleted file mode 100644[m
[1mindex 78a030a..0000000[m
[1m--- a/public/500.html[m
[1m+++ /dev/null[m
[36m@@ -1,66 +0,0 @@[m
[31m-<!DOCTYPE html>[m
[31m-<html>[m
[31m-<head>[m
[31m-  <title>We're sorry, but something went wrong (500)</title>[m
[31m-  <meta name="viewport" content="width=device-width,initial-scale=1">[m
[31m-  <style>[m
[31m-  .rails-default-error-page {[m
[31m-    background-color: #EFEFEF;[m
[31m-    color: #2E2F30;[m
[31m-    text-align: center;[m
[31m-    font-family: arial, sans-serif;[m
[31m-    margin: 0;[m
[31m-  }[m
[31m-[m
[31m-  .rails-default-error-page div.dialog {[m
[31m-    width: 95%;[m
[31m-    max-width: 33em;[m
[31m-    margin: 4em auto 0;[m
[31m-  }[m
[31m-[m
[31m-  .rails-default-error-page div.dialog > div {[m
[31m-    border: 1px solid #CCC;[m
[31m-    border-right-color: #999;[m
[31m-    border-left-color: #999;[m
[31m-    border-bottom-color: #BBB;[m
[31m-    border-top: #B00100 solid 4px;[m
[31m-    border-top-left-radius: 9px;[m
[31m-    border-top-right-radius: 9px;[m
[31m-    background-color: white;[m
[31m-    padding: 7px 12% 0;[m
[31m-    box-shadow: 0 3px 8px rgba(50, 50, 50, 0.17);[m
[31m-  }[m
[31m-[m
[31m-  .rails-default-error-page h1 {[m
[31m-    font-size: 100%;[m
[31m-    color: #730E15;[m
[31m-    line-height: 1.5em;[m
[31m-  }[m
[31m-[m
[31m-  .rails-default-error-page div.dialog > p {[m
[31m-    margin: 0 0 1em;[m
[31m-    padding: 1em;[m
[31m-    background-color: #F7F7F7;[m
[31m-    border: 1px solid #CCC;[m
[31m-    border-right-color: #999;[m
[31m-    border-left-color: #999;[m
[31m-    border-bottom-color: #999;[m
[31m-    border-bottom-left-radius: 4px;[m
[31m-    border-bottom-right-radius: 4px;[m
[31m-    border-top-color: #DADADA;[m
[31m-    color: #666;[m
[31m-    box-shadow: 0 3px 8px rgba(50, 50, 50, 0.17);[m
[31m-  }[m
[31m-  </style>[m
[31m-</head>[m
[31m-[m
[31m-<body class="rails-default-error-page">[m
[31m-  <!-- This file lives in public/500.html -->[m
[31m-  <div class="dialog">[m
[31m-    <div>[m
[31m-      <h1>We're sorry, but something went wrong.</h1>[m
[31m-    </div>[m
[31m-    <p>If you are the application owner check the logs for more information.</p>[m
[31m-  </div>[m
[31m-</body>[m
[31m-</html>[m
[1mdiff --git a/public/error_message.txt b/public/error_message.txt[m
[1mindex 2d2105c..37afb4c 100644[m
[1m--- a/public/error_message.txt[m
[1m+++ b/public/error_message.txt[m
[36m@@ -1,4 +1,2 @@[m
[31m-Error Time: 2024-04-17 22:39:17 +0530	 Error: undefined method `no_method_error_generator' for an instance of ErrorDataController[m
[31m-Error Time: 2024-04-17 22:39:23 +0530	 Error: undefined method `no_method_error_generator' for an instance of ErrorDataController[m
[31m-Error Time: 2024-04-17 22:39:23 +0530	 Error: undefined method `no_method_error_generator' for an instance of ErrorDataController[m
[31m-Error Time: 2024-04-17 22:39:24 +0530	 Error: undefined method `no_method_error_generator' for an instance of ErrorDataController[m
[32m+[m[32mError Time: 2024-04-19 10:19:29 +0530	 Error: undefined method `no_method_error_generator' for an instance of ErrorDataController[m
[32m+[m[32mError Time: 2024-04-19 10:19:47 +0530	 Error: undefined method `no_method_error_generator' for an instance of ErrorDataController[m
