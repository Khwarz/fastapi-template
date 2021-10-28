from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.core import tasks, config


def get_application():
    app = FastAPI(title=config.PROJECT_NAME, version="1.0.0")

    app.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

    app.add_event_handler("startup", tasks.create_start_app_handler(app))
    app.add_event_handler("shutdown", tasks.create_stop_app_handler(app))

    # app.include_router(router, prefix='/api')

    return app


app = get_application()
