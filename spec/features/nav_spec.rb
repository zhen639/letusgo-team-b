# encoding: utf-8
require_relative '../spec_helper'

describe "nav bar should be rendered based on role" ,:type => :feature do
  describe "testing with guest", :js =>true do
    it "should have items link and login link when visit" do
      visit '/'
      expect(page).to have_content('商品列表')
      expect(page).to have_content('登陆')
    end
  end
  describe "testing with customer", :js =>true do
    it "should have items-link,cart-link and login-link when visit" do
      page.set_rack_session user: "customer", isLogin: true, role: "customer"
      visit '/'
      expect(page).to have_content('商品列表')
      expect(page).to have_content('customer')
      expect(page).to have_content('退出')
      expect(page).to have_content('购物车')
    end
  end
  describe "testing with managre", :js =>true do
    it "should have admin-link and orders-link when visit" do
      page.set_rack_session user: "manager", isLogin: true, role: "manager"
      visit '/'
      expect(page).to have_content('商品管理')
      expect(page).to have_content('订单详情')
      expect(page).to have_content('manager')
      expect(page).to have_content('退出')
    end
  end
end
