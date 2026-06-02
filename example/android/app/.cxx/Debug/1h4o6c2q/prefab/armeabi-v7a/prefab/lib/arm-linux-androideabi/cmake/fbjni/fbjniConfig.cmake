if(NOT TARGET fbjni::fbjni)
add_library(fbjni::fbjni SHARED IMPORTED)
set_target_properties(fbjni::fbjni PROPERTIES
    IMPORTED_LOCATION "/Users/Sankalp-Gupta/.gradle/caches/8.8/transforms/662252eae8736c47cb10f483a13867b4/transformed/jetified-fbjni-0.6.0/prefab/modules/fbjni/libs/android.armeabi-v7a/libfbjni.so"
    INTERFACE_INCLUDE_DIRECTORIES "/Users/Sankalp-Gupta/.gradle/caches/8.8/transforms/662252eae8736c47cb10f483a13867b4/transformed/jetified-fbjni-0.6.0/prefab/modules/fbjni/include"
    INTERFACE_LINK_LIBRARIES ""
)
endif()

