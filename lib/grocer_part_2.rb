require_relative './part_1_solution.rb'
require 'pry'

def apply_coupons(cart, coupons)
  coupons.each do |coupon_item|
    cart.each do |grocery_item|
      if coupon_item[:item] == grocery_item[:item] && grocery_item[:count] >= coupon_item[:num]
        cart.push(
          { 
          :item => ( coupon_item[:item] + " W/COUPON" ),
          :price => ( coupon_item[:cost] / coupon_item[:num] ),
          :clearance => grocery_item[:clearance],
          :count => coupon_item[:num]
          })
        grocery_item[:count] -= coupon_item[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |grocery_item|
    if grocery_item[:clearance] === true
      grocery_item[:price] *= 0.8
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(consolidated_cart, coupons)
  processed_cart = apply_clearance(coupon_cart)
  total = 0 
  processed_cart.each do |grocery_item|
    total = total + (grocery_item[:price] * grocery_item[:count])
  end
  if total >= 100
    total *= 0.9
  end
  total.round(2)
end

