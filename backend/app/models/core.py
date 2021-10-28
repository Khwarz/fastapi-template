from pydantic import BaseModel, validator
from datetime import datetime
from typing import Optional


class CoreModel(BaseModel):
    """
    Any common logic to be shared by all the models goes here.
    """
    pass


class DateTimeModelMixin(BaseModel):
    created_at: Optional[datetime]
    updated_at: Optional[datetime]

    @validator
    def default_datetime(cls, value: datetime) -> datetime:
        return value or datetime.datetime.now()


class IDModelMixin(BaseModel):
    id: int
