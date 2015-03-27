/**
 * @license Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.html or http://ckeditor.com/license
 */


CKEDITOR.editorConfig = function( config ) {
  config.uiColor = '#f4f4f4';
  config.language = 'en';
  config.filebrowserBrowseUrl = "/ckeditor/attachment_files";
  config.filebrowserFlashBrowseUrl = "/ckeditor/attachment_files";
  config.filebrowserFlashUploadUrl = "/ckeditor/attachment_files";
  config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures";
  config.filebrowserImageBrowseUrl = "/ckeditor/pictures";
  config.filebrowserImageUploadUrl = "/ckeditor/pictures";
  config.filebrowserUploadUrl = "/ckeditor/attachment_files";
	config.toolbar_Pure = [
		'/', {
			name: 'basicstyles',
			items: ['Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat']
		}, {
			name: 'paragraph',
			items: ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 'BidiLtr', 'BidiRtl']
		}, {
			name: 'links',
			items: ['Link', 'Unlink']
		}, '/', {
			name: 'styles',
			items: ['Styles', 'Format', 'Font', 'FontSize']
		}, {
			name: 'colors',
			items: ['TextColor', 'BGColor']
		}, {
			name: 'insert',
			items: ['Image', 'Table', 'HorizontalRule', 'PageBreak']
		}
	];
	config.toolbar = 'Pure';
	return true;
};
