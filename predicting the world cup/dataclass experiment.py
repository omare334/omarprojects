from dataclasses import dataclass

@dataclass
class Blogpost:
    user: str
    likes: int = 0 #default values must be last

    def add_likes(self, n):
        self.likes += n
    def add_user(self, n):
        self.user += n



b1 = Blogpost(input(str("Enter the user name: ")))
print(b1)

b1.add_likes(10)
god = input(str("Enter the user name: "))
b1.add_user(god)
print(b1)
b2= Blogpost("John", 5)
print(b2)




