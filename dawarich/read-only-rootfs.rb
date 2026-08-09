# The Rails and DataMigrate schema dumps are generated build artifacts.  They
# cannot be stored in the immutable application source at runtime.
ActiveRecord.dump_schema_after_migration = false
