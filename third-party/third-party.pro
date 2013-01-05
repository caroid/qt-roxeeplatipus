TEMPLATE = subdirs

OTHER_FILES +=  $$PWD/README \
                $$PWD/bootstrap.sh

include($$PWD/../conf/conf.pri)

# Only mac has deps for now
mac{
    !isEmpty(ROXEE_INTERNAL_VERSION){
        message( -> Using internal third-party $${ROXEE_INTERNAL_VERSION})
        system(./bootstrap.sh)
    }
}
