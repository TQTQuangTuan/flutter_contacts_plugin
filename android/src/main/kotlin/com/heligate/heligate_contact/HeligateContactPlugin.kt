package com.heligate.heligate_contact

import android.app.Activity
import android.content.Intent
import android.provider.ContactsContract
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.Registrar

/** HeligateContactPlugin */
class HeligateContactPlugin: FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  val PICK_CONTACT_RESULT_CODE = 36
  var act: Activity? = null
  private lateinit var channel : MethodChannel
  private lateinit var result: Result

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "heligate_contact")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    this.result = result
    if (call.method == "getAContact") {
      val intent = Intent(Intent.ACTION_PICK, ContactsContract.Contacts.CONTENT_URI)
      act?.startActivityForResult(intent, PICK_CONTACT_RESULT_CODE)
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    act = binding.activity
    binding.addActivityResultListener(this)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    act = null;
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    act = binding.activity
    binding.addActivityResultListener(this)
  }

  override fun onDetachedFromActivity() {
    act = null;
  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
    if (requestCode == PICK_CONTACT_RESULT_CODE) {
      if (resultCode == Activity.RESULT_OK) {
        if (data != null) {
          val contactData = data.data
          android.util.Log.i("LOG __________", "______________________________")
          val c = act!!.contentResolver.query(contactData!!, null, null, null, null)
          if (c!!.moveToFirst()) {
            val name = c.getString(c.getColumnIndex(ContactsContract.Contacts.DISPLAY_NAME))
            result.success(name)
            return true
          }
        }
      }
    }
    return false
  }
}
