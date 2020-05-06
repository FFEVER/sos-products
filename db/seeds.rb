# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Initialize categories
Category.destroy_all
categories = JSON.parse(File.read(Rails.root.join('db/categories.json')))
categories.each do |category|
  parent_obj = Category.create!(name_en: category['name_en'], name_th: category['name_th'])
  puts "parent #{parent_obj.name_en} created!"
  category['subcategories'].each do |subcategory|
    sub_obj = Category.create!(
        name_en: subcategory['name_en'],
        name_th: subcategory['name_th'],
        parent: parent_obj
    )

    puts "subcategory #{sub_obj.name_en} created!"
  end
end

# Example products
# Product.destroy_all
# p1 = Product.create(
#     title: "Coach2020 กระเป๋าหญิงถังกระเป๋าสบายๆที่เรียบง่ายกระเป๋าสะพายกระเป๋า Messenger ความจุขนาดใหญ่กระเป๋าผู้หญิง",
#     user_id: 1,
#     long_desc: "คุณสามารถสั่งซื้อโดยตรงและเราจะจัดส่งโดยเร็วที่สุด คุณจะเห็นการอัปเดตสถานะหลังจากคลังสินค้า shopee ได้รับและสแกนพัสดุโดยปกติ 1-3 วันหลังจากเราจัดส่ง
#
# วัสดุ: หนัง
#
# ซื้อจากเราทำไม
# ✅ดั้งเดิมและแท้
# bag กระเป๋าของนักออกแบบแฟชั่นทำให้คุณพิเศษและเปล่งประกาย!
# ✅ผลิตภัณฑ์ทั้งหมดของเรามีคุณภาพสูงในราคาที่เหมาะสม รับประกันความพึงพอใจ 100%
# ✅สินค้าพร้อมส่งต่างประเทศ เราใช้การขนส่งอย่างเป็นทางการของ shopee SLS ปลอดภัยและเชื่อถือได้โดยปกติแล้วจะจัดส่งภายใน 5 - 8 วันหลังจากที่ Shopee ได้รับ
# rate โปรดให้คะแนนเรา 5 ครั้ง⭐⭐⭐⭐⭐ด้วยความคิดเห็นและคุณจะได้รับส่วนลดเพิ่มเติมในการสั่งซื้อครั้งต่อไป
#  # 2020new！ overseashandbag #Originalhandbag # กระเป๋าสะพายข้าง handbag # กระเป๋าสะพายข้าง handbag # กระเป๋าสะพายไหล่ดอกเดซี่สีแดง # กระเป๋าสะพายไหล่ handbag # กระเป๋าสะพายไหล่ handbag # กระเป๋าสะพายไหล่ handbag # กระเป๋าสะพายไหล่ handbag # กระเป๋าสะพายไหล่ handbag # กระเป๋าสะพายไหล่ handbag # กระเป๋าสะพายไหล่ handbag # กระเป๋าสะพายไหล่ ถุง
# พื้นผิว: Cowhideถุงถังไหล่สะพายอเนกประสงค์ความยาวด้านล่าง 24 สูง 27",
#     price: 50,
#     stock: 300,
#     sold_quantity: 10,
# )
# p1.categories << Category.find_by(name_en: "Bags")
# puts "#{p1.title} created!"
#
# p2 = Product.create(
#     title: "Imou กล้องวงจรปิด Cue 1080p Full HD Security IP Camera ประกันศูนย์ Synnex (IPC-C22P)",
#     user_id: 1,
#     long_desc: "รายละเอียดสินค้า
# - ความละเอียดตัวกล้องถึง 1080p หรือ FullHD
# - ระบบ Night Vision ในที่ที่ไม่มีแสง ก็ยังมองเห็นด้วยระบบอินฟาเรดภายใน
# - ระบบ Motion Detection จัดภาพอัฉริยะ ทำให้คุณไม่พลาดทุกการเคลื่อนไหว
# - ระบบ Two-way Talk สามารถพูดโต้-ตอบกันผ่านแอพพลิเคชั่นอย่างง่ายดาย
# - สามารถใช้ Cloud บันทึกหรือเลือกใช้ เมมโมรี่การ์ดได้
#
# • สิ่งที่อยู่ในกล่อง
# - 1 x กล้อง
# - 1 x คู่มือเริ่มต้นแบบย่อ
# - 1 x อะแดปเตอร์จ่ายไฟ
# - 1 x สาย USB
# - 1 x ชุดสกรู
# - 1 x บอร์ดการติดตั้งแบบรวดเร็ว
# - 1 x แผนที่ตำแหน่งติดตั้ง
# - ประกันศูนย์ Synnex ระยะเวลา 1 ปี",
#     price: 30000,
#     stock: 20,
#     sold_quantity: 0,
# )
# p2.categories << Category.find_by(name_en: "CCTV")
# puts "#{p2.title} created!"
#
# p3 = Product.create(
#     title: "Panasonic Lens G 25 mm. F1.7 ASPH [รับประกัน 1 ปี By AVcentershop ]",
#     user_id: 2,
#     long_desc: "***เลนส์ของใหม่ใส่กล่องขาว เนื่องจากเป็นเลนส์แยกมาจากชุด kit ***
#
# Panasonic Lumix G 25mm f1.7
# -โครงสร้างชิ้นเลนส์ 8 ชิ้น 7กลุ่ม
# - ทางยาวโฟกัส 25 มม.
# - ไดอะแฟรม 7 ใบ
# - เปิดหน้ากล้องสุด f/1.7, แคบสุด f/16
# - ระยะโฟกัสใกล้สุด 0.25 เมตร
# - ขนาดฟิลเตอร์ 46 มม.
# - ความสูงเลนส์ 52 มม.
# - น้ำหนัก 125 กรัม
# -มีสีดำและสีเงิน
#
#  (สินค้าไม่มีกล่อง เนื่องจากแยกจากชุดคิท)
#
# Line : @avcentershop (อย่าลืมใส่ @ นะคะ)
# Facebook : AVcentershop
# โทร : (082) 318 8555, (088) 815 0555 (เวลา11.00-20.00น.)",
#     price: 20,
#     stock: 50000,
#     sold_quantity: 20,
# )
# p3.categories << Category.find_by(name_en: "Lens")
# puts "#{p3.title} created!"
#
