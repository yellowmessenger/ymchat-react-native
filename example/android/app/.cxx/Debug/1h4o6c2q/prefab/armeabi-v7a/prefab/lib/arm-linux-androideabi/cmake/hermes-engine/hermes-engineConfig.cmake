if(NOT TARGET hermes-engine::libhermes)
add_library(hermes-engine::libhermes SHARED IMPORTED)
set_target_properties(hermes-engine::libhermes PROPERTIES
    IMPORTED_LOCATION "/Users/Sankalp-Gupta/.gradle/caches/8.8/transforms/fc7e75446ccc2f214c78e41d0a72135c/transformed/jetified-hermes-android-0.76.5-debug/prefab/modules/libhermes/libs/android.armeabi-v7a/libhermes.so"
    INTERFACE_INCLUDE_DIRECTORIES "/Users/Sankalp-Gupta/.gradle/caches/8.8/transforms/fc7e75446ccc2f214c78e41d0a72135c/transformed/jetified-hermes-android-0.76.5-debug/prefab/modules/libhermes/include"
    INTERFACE_LINK_LIBRARIES ""
)
endif()

