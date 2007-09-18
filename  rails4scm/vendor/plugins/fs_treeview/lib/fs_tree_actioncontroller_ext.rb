# 扩展 ActionController::Base类，增加指定回调的方法，即函数callback_object（）
ActionController::Base.class_eval do 

   attr_accessor :callback_object

   # 用法，在业务程序的 controller中，增加以下调用

   #  set_callback_object 对象
   #
   # 或者
   #
   #  set_callback_object :get_callback_object
   #
   #  def get_callback_object
   #    return  某个对象
   #  end
   
   def self.set_callback_object(callback_object)
     # TODO: 这个对象怎么和view类关联起来啊？
     p "---the callback object's className is:"
     p callback_object.class.to_s()
     
     # 这个函数干什么用的？ 抄下来再说
     # write_inheritable_attribute "callback_object", callback_object
   end

end