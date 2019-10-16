sara = User.create(name: "Sara", email: "sara@sara.com", password: "pw")

mike = User.create(name: "Mike", email: "mike@mike.com", password: "pw2")

Item.create(title: "dog chow", user_id: sara.id)

Item.create(title: "shaving cream", user_id: mike.id)