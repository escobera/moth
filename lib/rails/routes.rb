# encoding: utf-8
module ActionDispatch::Routing
  class Mapper
    # Includes moth_routes method for routes. This method is responsible to
    # generate all needed routes for sextant
    def moth_routes
      match 'caterpillar/test_bench',
        :controller => 'Caterpillar::Application',
        :action => 'portlet_test_bench',
        :as => :portlet_test_bench

      match 'caterpillar/test_bench/http_methods/:action',
        :controller => 'Caterpillar::HttpMethods'

      match 'caterpillar/test_bench/javascript/:action',
        :controller => 'Caterpillar::Js'

      match 'caterpillar/test_bench/css/:action',
        :controller => 'Caterpillar::Css'

      match 'caterpillar/test_bench/login/:action',
        :controller => 'Caterpillar::Login'

      match 'caterpillar/test_bench/resource/:action',
        :controller => 'Caterpillar::Resource'

      match 'caterpillar/test_bench/session/:action',
        :controller => 'Caterpillar::Session'

      match 'caterpillar/test_bench/user/:action',
        :controller => 'Caterpillar::User'

      match 'caterpillar/test_bench/liferay/:action',
        :controller => 'Caterpillar::Liferay'

      match 'caterpillar/test_bench/xhr/:action',
        :controller => 'Caterpillar::Xhr'

      # Liferay GID
      match 'caterpillar/test_bench/liferay/:action/gid/:gid',
        :controller => 'Caterpillar::Liferay'

      # xUnit test routes
      match 'caterpillar/test_bench/junit/:action',
        :controller => 'Caterpillar::Junit'

      # # index
      match 'caterpillar/',
        :controller => 'Caterpillar::Application',
        :action => "index",
        :as => :caterpillar

    end
  end
end
