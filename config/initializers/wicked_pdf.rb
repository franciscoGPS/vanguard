if Rails.env.staging? || Rails.env.production?
  wkhtmltopdf_path = "#{Rails.root}/bin/wkhtmltopdf-amd64"
else
  wkhtmltopdf_path = '/usr/local/bin/wkhtmltopdf' # OS X URL
end

WickedPdf.config = { exe_path: wkhtmltopdf_path, wkhtmltopdf: wkhtmltopdf_path }
