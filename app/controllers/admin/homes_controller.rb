require "open3"
class Admin::HomesController < Admin::BaseController

  def index
    @connet = current_connection
  end

  def start_service
    List.generate_config
    o, s = Open3.capture2("ssserver -c #{ShadowSock.first.local_path} -d restart")
    o, s = Open3.capture2("ssserver -c #{ShadowSock.first.local_path} -d start") if o.blank?
    redirect_to admin_root_path, notice:"ShadowSocks Service Starting"
  end

private

  def current_connection
    o, s = Open3.capture2("lsof -i | grep 'ssserver' | grep 'ESTABLISHED' | grep ':8' | wc -l")
    total = o.chomp
  end
end
