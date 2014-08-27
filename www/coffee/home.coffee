###
# This file is part of Invenio Mobile.
# Copyright (C) 2014 CERN.
#
# Invenio Mobile is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the
# License, or (at your option) any later version.
#
# Invenio Mobile is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Invenio Mobile; if not, write to the Free Software Foundation, Inc.,
# 59 Temple Place, Suite 330, Boston, MA 02111-1307, USA.
###

# Logic #

params = parseHashParameters()
startTab = '#' + (params.tab ? 'search') + 'Tab'

# Event handlers #

tabClicked = (tabName) ->
	params.tab = tabName
	updateHashParameters(params)

# On load #

$(startTab).addClass('active')
$('#homeTabs').tabBar(tabClicked)

