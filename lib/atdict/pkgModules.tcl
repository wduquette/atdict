#-------------------------------------------------------------------------
# TITLE: 
#    pkgModules.tcl
#
# PROJECT:
#    atdict: Your project description
#
# DESCRIPTION:
#    atdict(n): Package Loader
#
#    Generated by Quill
#
#-------------------------------------------------------------------------

#-------------------------------------------------------------------------
# Provide Package

# -quill-provide-begin DO NOT EDIT BY HAND
package provide atdict 0.0a0
# -quill-provide-end

#-------------------------------------------------------------------------
# Require Packages

# -quill-require-begin INSERT PACKAGE REQUIRES HERE
# -quill-require-end

#-------------------------------------------------------------------------
# Get the library directory

namespace eval ::atdict:: {
    variable library [file dirname [info script]]
}

source [file join $::atdict::library atdict.tcl]
