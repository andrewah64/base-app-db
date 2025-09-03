do $$
begin
        assert(select true from pg_roles where rolname = 'base_owner');
end$$;
