package com.example.nosh_now_application
import android.content.Intent
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.json.JSONException
import org.json.JSONObject
import vn.momo.momo_partner.AppMoMoLib
import java.time.temporal.TemporalAmount

class MainActivity: FlutterActivity() {
    private val CHANNEL = "payment"
    private val environment = 0 //developer default
    private val merchantName = "MOMO"
    private val merchantCode = "MOMOIQA420180417"
    private val merchantNameLabel = "MOMO"
    private val description = "Thanh toán đơn hàng"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "momo") {
                AppMoMoLib.getInstance().setEnvironment(AppMoMoLib.ENVIRONMENT.DEVELOPMENT)
                val orderId = call.argument<String>("orderId")?:"0"
                val amount = call.argument<String>("amount")?:"0"
                println("Amount" + amount);
                requestPayment(orderId, amount)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun requestPayment(orderId: String, amount: String) {
        AppMoMoLib.getInstance().setAction(AppMoMoLib.ACTION.PAYMENT)
        AppMoMoLib.getInstance().setActionType(AppMoMoLib.ACTION_TYPE.GET_TOKEN)

        val eventValue: MutableMap<String, Any> = HashMap()
        //client Required
        eventValue["merchantname"] = merchantName
        eventValue["merchantcode"] = merchantCode
        eventValue["amount"] = amount.toDouble().toInt() // Kiểu integer
        eventValue["orderId"] = orderId
        eventValue["orderLabel"] = "Order Label" // gán nhãn

        //client Optional - bill info
        eventValue["merchantnamelabel"] = "Service" // gán nhãn
        eventValue["fee"] = 0 // Kiểu integer
        eventValue["description"] = description // mô tả đơn hàng - short description

        //client extra data
        eventValue["requestId"] = merchantCode + "merchant_billId_" + System.currentTimeMillis()
        eventValue["partnerCode"] = merchantCode
        //Example extra data
        eventValue["extraData"] = ""
        eventValue["extra"] = ""
        AppMoMoLib.getInstance().requestMoMoCallBack(this, eventValue)
    }

    private fun sendResultToFlutter(status: String, message: String, token: String?) {
        flutterEngine?.dartExecutor?.binaryMessenger?.let {
            MethodChannel(it, CHANNEL).invokeMethod("onPaymentResult", hashMapOf(
                "status" to status,
                "message" to message,
                "token" to token
            ))
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == AppMoMoLib.getInstance().REQUEST_CODE_MOMO && resultCode == -1) {
            data?.let {
                when (it.getIntExtra("status", -1)) {
                    0 -> {
                        // TOKEN IS AVAILABLE
                        val token = it.getStringExtra("data") // Token response

                        if (!token.isNullOrEmpty()) {
                            // TODO: send phoneNumber & token to your server side to process payment with MoMo server
                            // IF Momo topup success, continue to process your order
                            println("success")
                            sendResultToFlutter("success", "Get token " + it.getStringExtra("message"), token)
                        } else {
                            sendResultToFlutter("fail", "No information received", null)
                        }
                    }
                    1 -> {
                        // TOKEN FAIL
                        val message = it.getStringExtra("message") ?: "Failed"
                        sendResultToFlutter("fail", message, null)
                    }
                    2 -> sendResultToFlutter("fail", "No information received", null)
                    else -> sendResultToFlutter("fail", "No information received", null)
                }
            } ?: sendResultToFlutter("fail", "No information received", null)
        } else {
            sendResultToFlutter("fail", "No information received or something wrong", null)
        }
    }
}
