import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/routes/app_pages.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://fbqtkzofnzbwcerofwcg.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZicXRrem9mbnpid2Nlcm9md2NnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI0MjgxMTMsImV4cCI6MjA0ODAwNDExM30.6RX3C2TPGl5vXflIS091Tq356HA1ipASoLGTd_1FO7w',
  );
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
