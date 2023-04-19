defmodule FormLoadingWeb.PageLive do
  use FormLoadingWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :form, to_form(%{}))}
  end

  def handle_event("form_changed", _params, socket) do
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="space-y-4">
      <p>The documentation states that:</p>
      <quote class="pl-4 italic my-4 block">
        Additionally, any phx- event may dispatch page loading events by annotating the
        DOM element with phx-page-loading. This is useful for showing main page
        loading status, for example:
      </quote>
      <p>
        <a href="https://hexdocs.pm/phoenix_live_view/js-interop.html#live-navigation-events">
          https://hexdocs.pm/phoenix_live_view/js-interop.html#live-navigation-events
        </a>
      </p>

      <p>
        This is not true for forms, because the internal mechanisms receive the
        input element, not the containing form.
      </p>

      <p>This demo has 500ms of simulated latency.</p>

      <.form
        for={@form}
        class="flex flex-col space-y-4 border p-4"
        phx-change="form_changed"
        phx-submit="form_changed"
        phx-page-loading
      >
        <p>This form has `phx-page-loading` set on the form, but it has no effect.</p>

        <section>
          <label>
            <input type="checkbox" name={@form["checkbox_2"].name} />
            &lt;input /&gt; Clicking this input will not trigger a phx:page-loading-* event.
          </label>
        </section>

        <section>
          <label>
            <input type="checkbox" name={@form["checkbox_1"].name} phx-page-loading />
            &lt;input phx-page-loading/&gt; Clicking this input will trigger a phx:page-loading-* event, as the input itself has the attribute.
          </label>
        </section>

        <p>Submit performs as expected already.</p>
        <button  class="border" type="submit">Submit</button>
      </.form>
    </div>
    """
  end
end
