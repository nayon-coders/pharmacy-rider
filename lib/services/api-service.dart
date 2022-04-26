import 'dart:convert';

class ApiServise{
  static const String siteUrl = "https://apps.piit.us/my-pharmacy/";
  static const String baseUrl = "https://apps.piit.us/my-pharmacy/api/v1";

  static const String orders = baseUrl+"/admin/orders";
  static const String ordersDetails = baseUrl+"/admin/order";
  static const String requisitionsList = baseUrl+"/admin/requisitions";
  static const String products = baseUrl+"/products";
  static const String UpPrescriptionStatus = baseUrl+"admin/orders/"; //set default "5/change-status"
  static const String requisitionsListFile = "/requisition-files";
  static const String UserAttendance = baseUrl+"/admin/attendance";
  static const String AttendanceUpdate = baseUrl+"/admin/attendance/store";
  static const String SarchProduct = baseUrl+"/search";
}