add_library(cmocka cmocka.c)

target_include_directories(cmocka
                           PRIVATE
                               ${CMOCKA_PLATFORM_INCLUDE}
                               ${cmocka_BINARY_DIR}
                           PUBLIC
                               $<BUILD_INTERFACE:${cmocka-header_SOURCE_DIR}>
                               $<INSTALL_INTERFACE:include>)

target_link_libraries(cmocka PRIVATE ${CMOCKA_LINK_LIBRARIES})
set_property(TARGET
                 cmocka
             PROPERTY
                 DEFINE_SYMBOL
                     CMOCKA_EXPORTS
)

set_property(TARGET
                 cmocka
             PROPERTY
                VERSION
                    ${LIBRARY_VERSION}
)
set_property(TARGET
                 cmocka
             PROPERTY
                SOVERSION
                    ${LIBRARY_SOVERSION})

set_property(TARGET
                cmocka
             PROPERTY
                LINK_FLAGS
                "${DEFAULT_LINK_FLAGS}")
