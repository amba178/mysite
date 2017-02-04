jQuery(function() {
  return $('#fileupload').fileupload({
    disableImageResize: /Android(?!.*Chrome)|Opera/.test(window.navigator && navigator.userAgent),
    imageMaxHeight: 600,
    imageMaxWidth: 800,
    imageCrop: true,
    process: [
            {
                action: 'load',
                fileTypes: /^image\/(gif|jpeg|png)$/,
                maxFileSize: 20000000 // 20MB
            },
            {
                action: 'resize',
                maxWidth: 300,
                maxHeight: 150,
                minWidth: 80,
                minHeight: 60
            },
            {
                action: 'save'
            }
        ],
    add: function(e, data) {
      var file, types, current_data;
      current_data = $(this);
      types = /(\.|\/)(gif|jpe?g|png)$/i;
      file = data.files[0];
      if (types.test(file.type) || types.test(file.name)) {

        data.context = $(tmpl("template-upload", file));
        $('#fileupload').append(data.context);
        //resizing the image to desired size
        data.process(function(){
          return current_data.fileupload('process', data);
        }).done(function() {
           return data.submit();
        });
      } else {
        return alert(file.name + " is not a gif, jpeg, or png image file");
      }
    },
    progress: function(e, data) {
      console.log(data);
      var progress;
      if (data.context) {
        progress = parseInt(data.loaded / data.total * 100, 10);
        return data.context.find('.progress-bar').css('width', progress + '%');
      }
    },
    done: function(e, data) {
      var content, domain, file, path, to;
      file = data.files[0];
      domain = $('#fileupload').attr('action');
      path = $('#fileupload input[name=key]').val().replace('${filename}', file.name);
      to = $('#fileupload').data('post');
      content = {};
      content[$('#fileupload').data('as')] = domain + path;
      $.post(to, content);
      if (data.context) {
        return data.context.remove();
      }
    },
    fail: function(e, data) {
      alert(data.files[0].name + " failed to upload.");
      console.log("Upload failed:");
      return console.log(data);
    }
  });
});