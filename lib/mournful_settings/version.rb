module MournfulSettings
  VERSION = "0.1.0"
end

# History
# =======
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
