module MournfulSettings
  VERSION = "0.1.3"
end

# History
# =======
#
# 0.1.3: Handles lack of database on initial use
# ----------------------------------------------
# In a rails app, if a setting is used in an initializer before the settings
# table is created, the app could not be run to build the table. In this
# version, it is assumed that if the database is not present, the default
# setting should be used.
#
# 0.1.2: Add facility to select value type via active_admin form
# --------------------------------------------------------------
# Lack of value type was preventing new settings to be created via active admin
# form.
#
# 0.1.1: Improves query to find setting via for
# ---------------------------------------------
# It makes sense for settings to be identified via a symbol, as this is a label.
# However, best practice for querying a database is to pass in a string to
# represent the data being retrieved. So the _for_ method has been altered to
# convert the setting's name into a string before passing it to ActiveRecord
# within a query. See: https://github.com/ernie/squeel/issues/67
# 
# 0.1.0: Acts As Mournful Setting
# -------------------------------
# Changes the way Mournful settings are used. Settings can now be defined via
# an acts_as_mournful_setting declaration rather than inheriting from 
# MournfulSettings::Setting. Inheritance is still supported 
# 
# 
# 0.0.6: Adds default option
# --------------------------
# Allows alternative to be set, that will be used until setting defined
# 
# 
# 0.0.5: Corrects gem description
# -------------------------------
# No functional change.
# 
# 
# 0.0.4: Changing cipher configuration
# ------------------------------------
# Adds facility to allow cipher to be changed with existing live data
# 
# 
# 0.0.3: Encrypted by default
# ---------------------------
# Modifies model and active admin registration file to make encrypting settings
# the default behaviour.
# 
# 
# 0.0.2: Add active admin option
# ------------------------------
# Adds active admin integration options.
# 
# 
# 0.0.1: First release
# --------------------
# Adds Settings model to host app, with encrypted data storage.
#
