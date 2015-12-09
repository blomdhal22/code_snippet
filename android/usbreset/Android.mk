LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := usbreset.c

LOCAL_MODULE := usbreset

LOCAL_SHARED_LIBRARIES := libcutils libutils 

include $(BUILD_EXECUTABLE)
