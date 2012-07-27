TEMPLATE = subdirs

OTHER_FILES +=  $$PWD/README \
                $$PWD/bootstrap.sh

include($$PWD/../vars.pri)
include($$PWD/../conf/confbase.pri)

# Only mac has deps for now
mac{
    contains(ROXEE_THIRD_PARTY, internal){
        message( -> Using internal third-party)
        system(./bootstrap.sh)
    }
}
