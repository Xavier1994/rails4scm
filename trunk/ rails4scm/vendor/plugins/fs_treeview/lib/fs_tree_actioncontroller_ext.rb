# ��չ ActionController::Base�࣬����ָ���ص��ķ�����������callback_object����
ActionController::Base.class_eval do 

   attr_accessor :callback_object

   # �÷�����ҵ������ controller�У��������µ���

   #  set_callback_object ����
   #
   # ����
   #
   #  set_callback_object :get_callback_object
   #
   #  def get_callback_object
   #    return  ĳ������
   #  end
   
   def self.set_callback_object(callback_object)
     # TODO: ���������ô��view�������������
     p "---the callback object's className is:"
     p callback_object.class.to_s()
     
     # ���������ʲô�õģ� ��������˵
     # write_inheritable_attribute "callback_object", callback_object
   end

end