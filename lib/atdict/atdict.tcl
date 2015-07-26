#-------------------------------------------------------------------------
# TITLE: 
#    atdict.tcl
#
# PROJECT:
#    atdict: Your project description
#
# DESCRIPTION:
#    atdict(n): Implementation File
#
#-------------------------------------------------------------------------

#-------------------------------------------------------------------------
# Exported Commands

namespace eval ::atdict {
    namespace export \
        @
}

#-------------------------------------------------------------------------
# Commands

proc ::atdict::@ {args} {
    # FIRST, get the target
    set target [Lshift args]

    # FIRST, if there is no target, create an empty dictionary
    if {$target eq ""} {
        return [dict create]
    }

    # NEXT, determine what the first argument is:
    set tokens [split $target "."]

    if {[llength $tokens] == 2} {
        lassign $tokens dictvar key
        if {[string index $key end] eq ":"} {
            upvar 1 $dictvar this
            set method [dict get $this [string range $key 0 end-1]]
            return [uplevel 1 [list apply $method $dictvar {*}$args]] 
        } else {
            # Key access
            upvar 1 $dictvar this
    
            set accessor [Lshift args]
            if {$accessor eq ""} {
                return [dict get $this $key]
            } elseif {$accessor eq "="} {
                set value [lindex $args 0]
                dict set this $key $value
                return $value
            } elseif {$accessor eq ":="} {
                set value [uplevel 1 [list expr [lindex $args 0]]]
                dict set this $key $value
                return $value
            } elseif {$accessor eq "->"} {
                lassign $args arglist body
                set arglist [linsert $arglist 0 thisvar]
                set body "upvar 1 \$thisvar this\n$body"

                dict set this $key [list $arglist $body]
                return
            } else {
                error "Unknown dict accessor: \"$accessor\""
            }
        }
    } elseif {[llength $tokens] == 1} {
        # Just return the dictionary
        upvar 1 $dictvar this
        return $this
    } else {
        # Hmmm.  Could allow nested syntax, couldn't we?  Multiple tokens
        # represent multiple dictionary levels.
        error "Invalid syntax, multiple '.' connectors"
    }
}

proc ::atdict::Lshift {listvar} {
    upvar 1 $listvar thelist

    set result [lindex $thelist 0]
    set thelist [lrange $thelist 1 end]

    return $result
}