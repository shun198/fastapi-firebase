from dataclasses import dataclass

@dataclass
class User:
    id: int
    email: str
    username: str
    first_name: str
    last_name: str
