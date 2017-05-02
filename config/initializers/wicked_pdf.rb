if Rails.env.staging? || Rails.env.production?
  wkhtmltopdf_path = "#{Rails.root}/bin/wkhtmltopdf-amd64"
else
  #wkhtmltopdf_path = '/usr/local/bin/wkhtmltopdf' # OS X URL
  wkhtmltopdf_path = '/home/frisco/.rvm/gems/ruby-2.2.2/bin/wkhtmltopdf'
end

WickedPdf.config = { exe_path: wkhtmltopdf_path, wkhtmltopdf: wkhtmltopdf_path }
