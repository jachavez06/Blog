CKEDITOR.editorConfig = function (config) {
    config.allowedContent = true;
    config.removeFormatAttributes = '';
    config.entities = false;
    config.height = 500; 
    config.extraPlugins = 'codemirror';
    config.contentsCss = asset_path("javascript/ckeditor/contents.scss")
}
;
