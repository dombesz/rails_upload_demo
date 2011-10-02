class User < ActiveRecord::Base  

  def after_initialize
    self.uuid ||= UUID.new.generate
  end

  default_scope order('updated_at DESC')

  # validates_presence_of :file
  mount_uploader :file, FileUploader
  
end