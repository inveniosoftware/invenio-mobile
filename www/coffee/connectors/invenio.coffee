###
# This file is part of Invenio.
# Copyright (C) 2014 CERN.
#
# Invenio is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the
# License, or (at your option) any later version.
#
# Invenio is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Invenio; if not, write to the Free Software Foundation, Inc.,
# 59 Temple Place, Suite 330, Boston, MA 02111-1307, USA.
###

class @InvenioConnector

	## Static methods ##
	
	@getSourceFromURL = (url, callback, error) ->
		checkData = (data) ->
			unless data.invenioAPIVersion?
				error(jqXHR, 'parsererror', "invenioAPIVersion was not defined.")
				return

			callback(data)

		jqXHR = $.ajax(url: "#{url}api/info", success: checkData, error: error, dataType: 'json')
	
	## Instance methods ##

	constructor: (@source) ->

	compileQuery: (queryArray) ->
		query = ''
		for clause in queryArray
			query += clause.operation + ' ' if clause.operation?
			query += clause.field + ':' if clause.field?
			query += clause.value + ' '

		return query.trim()

	performQuery: (query, sort, pageStart, pageSize, callback) ->
		options = {
			query: escape(query),
			sort: sort
		}
		options.pageStart = pageStart if pageStart?
		options.pageSize  = pageSize  if pageSize?

		$.get("#{@source.url}api/search?#{$.param(options)}", callback, 'json')

	getRecord: (id, callback) ->
		$.get("#{@source.url}api/record/#{id}", callback, 'json')
	
	getFileURL: (recordID, fileName) ->
		return "#{@source.url}api/record/#{recordID}/files/#{fileName}"


registerConnector('invenio', InvenioConnector)