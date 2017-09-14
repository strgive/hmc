SET NAMES 'utf8';
DROP DATABASE IF EXISTS haomaiche;
CREATE DATABASE haomaiche CHARSET=UTF8;
USE haomaiche;

CREATE TABLE hmc_dish(
    did INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(64),
    price FLOAT(6,2),
    img_sm VARCHAR(64),
    img_lg VARCHAR(64),
    detail VARCHAR(2048)
);
set names GBK;
INSERT INTO hmc_dish(did,img_sm,img_lg,name,price,material,detail) VALUES
(   null,
    'car_01.jpg',
    'car_01_l.jpg',
    '劳斯莱斯(Rolls-Royce)',
    25600.00,
    '劳斯莱斯古斯特(Ghost)是劳斯莱斯汽车有限公司最新出厂的四门超豪华轿车，售价399万元起。劳斯莱斯古斯特搭载6.6升双涡轮增压V12发动机，匹配ZF公司的8速自动变速箱，功率发挥直逼500马力，尽管定位低于幻影Phantom,但是古斯特的动力却占了上风。',
    '古斯特(Ghost)与前系车型相比，车身略小、更具动感，一眼即可辨识出其纯正的劳斯莱斯汽车系统。古斯特不仅充满现代感，同时还成功传承了劳斯莱斯汽车品牌积蓄的丰底蕴。该车型是继劳斯莱斯幻影系列之后全新车系的首款新车；幻影系列包括幻影标准版、幻影加长版(四门豪华轿车)、幻影软顶敞篷车(敞篷车)以及幻影双门跑车(固定车顶)。 '
),
(   null,
    'car_02.jpg',
    'car_02_l.jpg',
    '宾利(bentley)',
    35400.00,
    '宾利(Bentley)是举世闻名的豪华汽车制造商，宾利品牌依然熠熠生辉，不断给世人呈现出尊贵、典雅与精工细做的高品质座驾。',
    '宾利欧陆是英国宾利汽车公司在2011年11月21日推出的一款汽车，设计最高时速329km/h，前置四驱驱动，车身重量在2475~2940千克，座位材质采用小牛皮。'
),
(   null,
    'car_03.jpg',
    'car_03_l.jpg',
    '法拉利(Ferrari)',
    37600.00,
    '法拉利是举世闻名的赛车和运动跑车的生产厂家，总部位于意大利马拉内罗（Maranello），由恩佐·法拉利（Enzo Ferrari）于1947年创办，主要制造一级方程式赛车、赛车及高性能跑车。',
    'LaFerrari是法拉利推出的一款旗舰级超级跑车，于2013年3月在日内瓦车展首次亮相，以取代法拉利Enzo车型，仅限量499台。LaFerrari拥有超凡极致的性能表现、空气动力效率以及操控性，为超级跑车树立了新的标杆。 LaFerrari采用被称为HY-KERS的混合动力系统，一台6.3升V12自然吸气引擎可输出588千瓦的最大功率，电动机独立输出120千瓦动力，使得LaFerrari的联合输出功率高达708千瓦。LaFerrari的0-100km/h加速时间<3 秒，0-200km/h加速<7 秒[1] ，0-300km/h更只需15秒，极速高达350km/h以上。'
),
(   null,
    'car_04.jpg',
    'car_04_l.jpg',
    '兰博基尼(Lamborghini)',
    26800.00,
    '兰博基尼（Automobili Lamborghini S.p.A.）是一家意大利汽车生产商，全球顶级跑车制造商及欧洲奢侈品标志之一，公司坐落于意大利圣亚加塔·波隆尼（Sant Agata Bolognese），由费鲁吉欧·兰博基尼在1963年创立。',
    '兰博基尼的传统是用斗牛的名字来命名新车，该款旗舰车型的名字Aventador（埃文塔多）同样来源于一头公牛，并且是西班牙斗牛界最勇猛的斗牛之一。该车敞篷版本于2013年2月进入中国，售738.88万元。此后，兰博基尼又陆续发布了Aventador LP720-4的硬顶版及敞篷版车型。这是继兰博基尼雷文顿Reventon以来兰博基尼公司的又一部新一代旗舰车型。'
),
(   null,
    'car_05.jpg',
    'car_05_l.jpg',
    '迈巴赫(Maybach)',
    35600.00,
    '迈巴赫一个汽车品牌。迈巴赫（德文：Maybach）与迈巴赫引擎制造厂（德文：Maybach-Motorenbau GmbH）是一曾经在1921年到1940年间活跃于欧洲地区的德国超豪华汽车品牌与制造厂。',
    '齐柏林——Zeppelin在德语中的本意是飞艇或飞船，这预示着迈巴赫新车不但拥有如同航空器一般复杂的装备，更可以让乘坐者获得个人包机般的尊贵体验。据悉，这款称雄超豪车市场的巅峰力作在全球限量发售100台。'
),
(   null,
    'car_06.jpg',
    'car_06_l.jpg',
    '阿斯顿马丁(Aston Martin)',
    26900.00,
    '阿斯顿·马丁（AstonMartin） 汽车公司设在英国盖顿，公司主要生产敞篷旅行车、赛车和限量版的跑车。阿斯顿.马丁公司始建于1913年3月，创始人是莱昂内尔·马丁和罗伯特·班。',
    '阿斯顿马丁DB11是阿斯顿·马丁旗下的一款超级跑车，是阿斯顿·马丁和梅赛德斯-奔驰合作的首款产品，被视为DB9的换代车型。'
),
(   null,
    'car_07.jpg',
    'car_07_l.jpg',
    '布加迪(Bugatti)BUGATTI',
    36000.00,
    'BUGATTI，这个创立至今已经有百余年历史的法国跑车品牌。提起奢侈品，大家肯定会联想到来自法国的各种奢侈品牌。而汽车中的奢侈品——布加迪(Bugatti)无疑是其中法国奢侈品牌中重要的一员。',
    'Bugatti Veyron中国市场登记命名为布加迪威航，即布加迪威龙，世界顶级超跑车的典范，最普通款型的中国市场价也要2500万元，高性能版本的售价则更是在3500万以上。其品牌源自意大利，由法国车厂负责生产，隶属于德国大众公司旗下。威航是Veyron的正式中文名，不过众多车迷更愿意称之为 威龙 。威航系列主要有SuperSport、GrandSport、Vitesse威速、爱马仕特别版、陶瓷特别版等细分车型，均搭载8.0L W16四涡轮增压发动机，极速434km/h。'
),
(   null,
    'car_08.jpg',
    'car_08_l.jpg',
    '迈凯伦(Mcalaren)',
    63000.00,
    '迈凯伦集团总部位于英国沃金 ( Woking) ，聚集了先进的高科技公司，每个公司都最大化地为迈凯轮在一级方程式运动领域的前沿技术中建立起的全球名声和美誉添砖加瓦。通过完全奉献、优质和杰出的实施原则，迈凯伦集团已在英国工程和技术界名列前茅。',
    '在375台迈凯伦P1被一抢而空之后，P1 GTR将成为迈凯伦沃金工厂除650S跑车外的新工作。P1 GTR将同样采用限量生产的模式，这一模式被认为是用于纪念迈凯伦前一台传奇跑车F1极限性能版本F1 GTR面世20周年。'
);

##SELECT * FROM hmc_dish;

CREATE TABLE hmc_order(
    oid INT PRIMARY KEY AUTO_INCREMENT,
    phone VARCHAR(16),
    user_name VARCHAR(16),
    sex INT,    /*1:男  2:女*/
    order_time LONG,
    addr VARCHAR(256),
    did INT
);
INSERT INTO hmc_order(oid, phone,user_name,sex,order_time,addr,did) VALUES
(NULL,'13501234567','婷婷',2,1445154859209,'江苏省苏州市',3),
(NULL,'13501234567','婷婷',2,1445254959209,'江苏省南京市',2),
(NULL,'13501234567','婷婷',2,1445354959209,'浙江省杭州市',5);

##SELECT * FROM hmc_order;