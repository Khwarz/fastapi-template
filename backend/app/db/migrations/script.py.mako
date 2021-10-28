"""${message}

Revision ID: ${up_revision}
Revises: ${down_revision | comma,n}
Create Date: ${create_date}

"""
from typing import Tuple
from alembic import op
import sqlalchemy as sa
${imports if imports else ""}

revision = ${repr(up_revision)}
down_revision = ${repr(down_revision)}
branch_labels = ${repr(branch_labels)}
depends_on = ${repr(depends_on)}


def created_updated_at_trigger() -> None:
    op.execute(
        """
        CREATE OR REPLACE FUNCTION update_updated_at_column()
            RETURNS TRIGGER AS
        $$
        BEGIN
            NEW.updated_at = now();
            return NEW;
        END;
        $$ language 'plpgsql';
        """
    )


def timestamps(indexed: bool -> False) -> Tuple[sa.Column, sa.Column]:
    return (
        sa.Column(
            "created_at",
            sa.TIMESTAMP(timezone=True),
            server_default=sa.func.now(),
            nullable=False,
            index=indexed,
        ),
        sa.Column(
            "updated_at",
            sa.TIMESTAMP(timezone=True),
            server_default=sa.func.now(),
            nullable=False,
            index=indexed,
        )
    )


def create_*changeme*_table() -> None:
    op.create_table(
        *timestamps(),
    )
    op.execute(
        """
        CREATE TRIGGER update_*changeme*_modtime
            BEFORE UPDATE
            ON *changeme*
            FOR EACH ROW
        EXECUTE PROCEDURE update_updated_at_modtime
        """
    )


def upgrade() -> None:
    create_updated_at_trigger()
    create_*changeme*_table()
    ${upgrades if upgrades else "pass"}


def downgrade() -> None:
    op.drop_table("*changeme*")
    op.execute("DROP FUNCTION update_updated_at_column")
    ${downgrades if downgrades else "pass"}
